////////////////////////////////////////学习笔记////////////////////////////////////////
/**
  * 1.该组件封装，可学习地方较多，这个组件封装的时候，采用了接口中转的方案【由于该组件的特殊性】，
  toast组件，我们只想简单的通过一个方法的调用使用，export出去之后，toast.show(参数)，直接
  使用就好，所以我们不需要<Toast />这样使用，但是我们又希望有视图展示，那么怎么办呢，我们封装下
  toast.show方法，调用ReactDOM方法，然后插入Document。
  * 2.在utils文件中，封装了createInstance方法，该方法就是在Document上创建一个视图。
  * 3.在使用文件中，如果import了该文件，然后就会生成createInstance方法中创建的视图，只不过该视图初始化不可见
**/

////////////////////////////////////////组件简介////////////////////////////////////////
/**
  简介：简单的提示框，类似iOS中的MBProgress，支持短语提示，支持回调隐藏
  依赖：内部组件，icon和fade
  -- 被动输入端：
  * 1.style属性，可配置最外层view的显示
  * 2.children属性，可配置遮罩层上的view
  -- 主动输出端：
  * 1.others属性，支持点击视图，回调函数
**/

////////////////////////////////////////使用代码////////////////////////////////////////
/**
  -- 可配置文字的loading
    <NormalTopImgBottomLab name={this.state.first} clickCallBack={() => {
      Toast.show({
        icon: 'check',
        content: 'API 调用'
      }, null, 3000);
    }}/>

  -- 纯文字loading
    <NormalTopImgBottomLab name={this.state.first} clickCallBack={() => {
      Toast.show({
        content: 'API 调'
      }, null, 1000);
    }}/>

  -- 显示loading
    <NormalTopImgBottomLab name={this.state.first} clickCallBack={() => {
      Toast.showLoading();
    }}/>

  -- 隐藏loading
    <NormalTopImgBottomLab name={this.state.first} clickCallBack={() => {
      Toast.hideLoading();
    }}/>
**/


////////////////////////////////////////源代码////////////////////////////////////////
import React from 'react';
import PropTypes from 'prop-types';
import {classNames,createInstance} from '../utils';
import './style.scss';
/**依赖内部组件**/
import Fade from '../Fade';
import {IconCheck,IconLoading} from '../Icon';


let apiInstance = null;

//虽然导出Toast组件，但是我们不会按常规<xxx />来使用，可以将它看做一个接口，Toast.method(args)
export default function Toast(props) {
  //属性解构赋值
  let {content,icon,className,...others} = props;
  //重命名类名，以后可在scss中扩展，增加样式
  className = classNames('toast',className);

//返回组件的方法，不是给外界使用的，是给本文件中ApiContainer使用的。
  return (
    <div className={className} {...others}>
      {icon ? <div>{mapIcon(icon)}</div>:null}
      <p>{content}</p>
    </div>
  );
}

/**属性检查**/
Toast.propTypes = {
  content: PropTypes.node,
  className: PropTypes.string
};


Toast.show = (props, fadeProps, time) => {
  //apiInstance为document方式添加的组件实例，Toast.show，类似于中转接口
  //之所以这样做中转接口，是【为了让使用者更加顺畅便捷，符合高内聚，低耦合设计】
  //我们当然也可以直接使用<Toast props/>，然后通过控制props控制显示和隐藏，但是这样使用就不会那么的面向对象了，不会那么简洁
  apiInstance.show(props, fadeProps, time);
};

Toast.hide = () => {
  apiInstance.hide();
};

Toast.showLoading = (content) => {
  apiInstance.showLoading(content);
};

Toast.hideLoading = () => {
  apiInstance.hideLoading();
};

Toast.showAttention = (content, time) => {
  apiInstance.showAttention(content, time);
};


function mapIcon(icon) {
  switch (icon) {
    case 'loading':
      return (<IconLoading />);
    case 'check':
      return (<IconCheck />);
    default:
      return icon;
  }
}

/**
 * 提供接口
 */

class ApiContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      props: {
        content: ''
      },
      fadeProps: {
        show: false
      }
    };  }



  render() {
    let {props, fadeProps} = this.state;

    return (
      <Fade {...fadeProps}>
        <Toast {...props} />
      </Fade>
    );
  }

  show(props, fadeProps, time) {
    let nextState = {
      props: {...this.state.props, ...props},
      fadeProps: {...this.state.fadeProps, ...fadeProps, show: true}
    };
    this.setState(nextState);

    if (typeof time === 'number') {
      clearTimeout(this.timer);
      this.timer = setTimeout(() => {
        this.hide();
      }, time);
    }
  }

  // 延时执行，单位：ms
  hide() {
    let nextState = {
      ...this.state,
      fadeProps: {...this.state.fadeProps, show: false}
    };

    this.setState(nextState);
  }

  showLoading(content = '加载中...') {
    let props = {icon: 'loading', content};
    this.show(props);
  }

  hideLoading() {
    this.hide();
  }

  showAttention(content, time = 2000) {
    let props = {icon: 'attention', content};
    this.show(props, {}, time);
  }
}

//使用utils中的createInstance方法，创建一个视图，只要引入该文件，就会在document上添加一个视图。
apiInstance = createInstance(ApiContainer);
