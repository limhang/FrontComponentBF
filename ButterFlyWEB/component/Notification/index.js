////////////////////////////////////////学习笔记////////////////////////////////////////
/**
 该组件的封装，可以看做之前react web view，组件封装的一次练习
 主要思路：由于该组件最开始并不在document上显示，所以还是做成api的形式，通过接口直接调用，类似函数调用，
 函数在js中，也是一个对象，对象就有属性和方法，也就是使用对象方法的形式调用，通过utlis中createInstance方法，将传入
 的组件加载到container中（如果container为空，则加载到document上）

 关于react-transition-group这个组件的理解，我们写转场动画的时候，最重要的是什么，是时间！！，我们设定transition-property，然后
 我们需要时间来对设定的property进行修改，那么怎样获取这个时间呢，看看这个第三方的一句话介绍吧
 "An easy way to perform animations when a React component enters or leaves the DOM"
 看到没，这个组件还有一点非常重要，就是这个动画一定是建立在组件的消失和出现的基础上的。只有将组件弄消失然后又弄显示出来，才能触犯动画。
 还有一点是，可以参考popup，
 **/

////////////////////////////////////////组件简介////////////////////////////////////////
/**
 简介：底部弹出提醒视图，类似原生的通知
 依赖：react-transition-group
 -- 被动输入端：
 * 1.通知的内容文字，这个视图消失的时间
 -- 主动输出端：
 * 1.没有主动输出任何东西，只是让用户看到一些信息，不交互
 **/

////////////////////////////////////////使用代码////////////////////////////////////////
/**
 Notification.show('show message',1000);
1s后消失
 **/

////////////////////////////////////////源文件////////////////////////////////////////
import React from 'react';
import PropTypes from 'prop-types';
import './style.scss';
import {createInstance} from '../utils';
import {CSSTransitionGroup} from 'react-transition-group' // ES6

//自定义参数,duration在这里表示消失和显示需要的时间【换句话就是我们给消失和显示动画多久的时间】
const duration = 400;

//这个对象就是我们使用的api中转接口
let apiInstance = null;

export default function Notification(props) {
  let {content} = props;
  return (
    // 整个第三方框架的作用域为notification

    // transition-duration={`${duration}ms`}
    <div className="notification">
      <div className="notification-content" >
        {content}
      </div>
    </div>
  )
}

Notification.defaultProps = {
  content: 'defaultMessage show'
};

Notification.prototype = {
  content: PropTypes.string
};

//我们先做一个最简单的组件，就是显示出传递过来的信息
Notification.show = function (message, time) {
  apiInstance.show(message, time);
};

//实际进行操作的最终接口
class ApiContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      content: '',
      show: false
    };
  }

  render() {
    return (
      <div className="buff">
        <CSSTransitionGroup
          //这个transitionName就是这个第三方框架作用的区域范围
          transitionName={'notification'}
          transitionEnterTimeout={duration}
          transitionLeaveTimeout={duration}>
          {this.state.show ? <Notification content={this.state.content}/> : null}
        </CSSTransitionGroup>
      </div>
    );
  }

  show(message, time) {
    this.setState({content: message, show: true});
    setTimeout(() => {
      this.hidden();
    }, time);
  }

  hidden() {
    this.setState({show: false});
  }


}

//由于js代码有执行顺序，所以应该将这句代码，放在ApiContainer类之后写
apiInstance = createInstance(ApiContainer);
