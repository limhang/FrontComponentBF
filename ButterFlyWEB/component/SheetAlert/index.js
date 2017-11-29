////////////////////////////////////////学习笔记]////////////////////////////////////////
/**这应该是第3次左右写这种组件了，所以更多是复习，这个组件是自己写的，没参考别人，更多的提升在scss文件，里面有一些心得**/

////////////////////////////////////////组件简介////////////////////////////////////////
/**
  简介：做成接口形式的组件，交互界面模范原生底部弹出选择框。【该组件的出现，一定是伴随一个点击事件】
  依赖：react-transition-group显示隐藏第三方
  -- 被动输入端：
  * 1.视图中children项目，支持自定义多个item
  -- 主动输出端：
  * 1.多个自定义的item的点击事件，也交由外界控制，所以实际上，没有输出
**/

////////////////////////////////////////使用代码////////////////////////////////////////
/**
 * contentArray -- 传递进去显示使用的字符串数组
 * fnArray -- 传递进去点击响应的函数
 let contentArray = ['拍照','摄影','相册'];
 let fnArray = [()=>{console.log('点击拍照')},()=>{console.log('点击摄影')},()=>{console.log('点击相册')}];
 SheetAlert.show(contentArray,fnArray);
**/

////////////////////////////////////////源文件////////////////////////////////////////
import React from 'react';
import PropTypes from 'prop-types';
import './style.scss';
import {createInstance} from '../utils'
import {CSSTransitionGroup} from 'react-transition-group' // ES6

//文件变量
const duration = 200;

//做接口的实例
let apiContainer = null;

export default function SheetAlert (props) {
	let {
	  contentArray,
    fnArray
	} = props;

  // //设置content中items的样式
  // let style = {height:itemHeight,borderBottom:1 solid };
  return (
	  //视图展示部分，也就是view，还是在这里；接口中转，逻辑控制还是交由接口模块
    <div className="alertSheet">
      {/*整个alertSheet部分*/}
      <div className="alertSheet-core">
        {/*多行item显示部分*/}
        <div onClick={apiContainer.hidden} className="alertSheet-core-content">
          {contentArray.map(function (item,index){
            return (
              <div key={index} onClick={fnArray[index]}>{item}</div>
            );
          })}
        </div>
        {/*底部取消按钮部分*/}
        <div className="alertSheet-core-cancle" onClick={apiContainer.hidden}>
          {'cancle'}
        </div>
      </div>
    </div>


	)
}

//提供给外界的显示接口，传入的array是一个数组，里面包含着需要显示的item
SheetAlert.show = (contentArray,fnArray) => {
  apiContainer.show(contentArray,fnArray);
};

class ApiContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      show: false, //这个组件肯定需要有显示和隐藏的功能 ，也正是因为这个，所以我们需要使用class类型的react（有变量保存的需要）
      contentArray: [], //传递进来的html元素数组，我们不需要在乎里面是什么，只需要显示就好
      fnArray: []
    };
    this.hidden = this.hidden.bind(this);
  }

  render() {
    let contentArray = this.state.contentArray;
    let fnArray = this.state.fnArray;
    return (
      <div>
        <CSSTransitionGroup
          transitionName={'alertSheet'}
          transitionEnterTimeout={duration}
          transitionLeaveTimeout={duration}>
          {this.state.show ? <SheetAlert contentArray={contentArray} fnArray={fnArray}/> : null}
        </CSSTransitionGroup>
      </div>
    );
  }

  //中转函数，控制显示
  show(contentArray,fnArray) {
    let nextState = {show: true, contentArray: [...contentArray], fnArray: [...fnArray]};
    this.setState(nextState);
  }
  //组件内使用函数，通过控制state中的show状态，决定是否显示sheetAlert
  hidden() {
    this.setState({show:false});
  }
}

apiContainer = createInstance(ApiContainer);
