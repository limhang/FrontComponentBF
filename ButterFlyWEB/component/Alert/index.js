////////////////////////////////////////学习笔记]////////////////////////////////////////

////////////////////////////////////////组件简介////////////////////////////////////////
/**
  简介：对于这种在视图上，会有显示和隐藏操作的视图，我还是采用接口的方式设计。样式就是模仿原生的弹出框
  依赖：暂无
  -- 被动输入端：
  * 1.支持输入标题
  * 2.支持输入内容
  * 3.默认左侧取消按钮，右侧确认按钮
  -- 主动输出端：
  * 1.支持取消按钮的回调
  * 2.支持确认按钮的回调
**/

////////////////////////////////////////使用代码////////////////////////////////////////
/**
 let AlertObject = {title:'标题',content:'contentMessage',cancleCallback:()=>{console.log('hhh');},comfirmCallback:()=>{console.log('xxx');}};
 Alert.show(AlertObject);
**/

////////////////////////////////////////源文件////////////////////////////////////////
import React from 'react';
import PropTypes from 'prop-types';
import './style.scss';
import {createInstance} from '../utils';

let apiContainer = null;

export default function Alert (props) {
	let {title,content,cancleCallback,comfirmCallback } = props;
  let nextCancleCallback = () => {
    cancleCallback();
    apiContainer.hidden();
  };
  let nextComfirmCallback = () => {
    comfirmCallback();
    apiContainer.hidden();
  }
	return (
	  //最核心的视图界面，我们还是在这里写，下面的apiContainer只做转发和逻辑控制
    <div className="alert">
      <div className="alert-core">
        <div className="alert-core-title">{title}</div>
        <div className="alert-core-content">{content}</div>
        <div className="alert-core-line"></div>
        <div className="alert-core-control">
          <span className="alert-core-control-cancle" onClick={nextCancleCallback}>取消</span>
          <span className="alert-core-control-comfirm" onClick={nextComfirmCallback}>确认</span>
        </div>
      </div>
    </div>
	)
}


//组件属性默认值

//组件类型检查
Alert.propTypes = {
  title: PropTypes.string,
  content: PropTypes.string,
  cancleCallback: PropTypes.func,
  comfirmCallback: PropTypes.func
};

//外部接口调用
Alert.show = (object) => {
  apiContainer.show(object);
};

//逻辑控制转发控制，apiContainer
class ApiContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      show: false,
      title: '',
      content: '',
      cancleCallback: null,
      comfirmCallback: null
    };
  }

  render() {
    let {show,...AlertProps} = this.state;
    return (
      <div>
        {this.state.show ? <Alert {...AlertProps}/> : null}
      </div>
    )
  }

  show(object) {
    let nextState = {...object,show:true};
    this.setState(nextState);
  }

  hidden() {
    this.setState({show:false});
  }
}

apiContainer = createInstance(ApiContainer);