////////////////////////////////////////组件简介////////////////////////////////////////
/**
  简介：弹出层遮罩，可自定义放在弹出层上的视图，默认遮罩这个屏幕，居中，距离顶部60px
  依赖：视图的淡入和淡出，依赖react-transition-group包
  -- 被动输入端：
  * 1.style属性，可配置最外层view的显示
  * 2.children属性，可配置遮罩层上的view
  -- 主动输出端：
  * 1.others属性，支持点击视图，回调函数
**/

////////////////////////////////////////使用代码////////////////////////////////////////
/**
  <Fade
    show={this.state.show}
    timingFunction='ease-in'
    onClick={() => {
    this.setState({'show': !this.state.show});
    }}
    style={{
    position: 'fixed',
    top: 0,
    left: 0,
    width: '100%',
    height: '100%',
    textAlign: 'center',
    paddingTop: '60px',
    backgroundColor: '#ddd'
  }}>
    <h1>ssss</h1>
    <h2>xxxxxxxxx</h2>
  </Fade>
**/


////////////////////////////////////////源文件////////////////////////////////////////
import React from 'react';
import PropTypes from 'prop-types';
import { CSSTransitionGroup } from 'react-transition-group' // ES6
import {classNames} from '../utils';
import './style.scss';

export default function Fade(props) {
  /**获取props**/
  let {
    //CSSTransitionGroup，属性配置
    show,
    duration,
    timingFunction,
    //获取控件的子孙node
    children,
    //可支持配置样式【针对真个view】
    style,
    //包裹整个弹出显示层的view，默认是div
    HtmlTag,
    //一些点击事件之类的
    ...others
  } = props;
  /**属性配置**/
  style = {
    ...style,
    transitionDuration: (duration + 'ms'),
    transitionTimingFunction: timingFunction
  };

  return (
    <CSSTransitionGroup
      transitionName={classNames('fade')}
      transitionEnterTimeout={duration}
      transitionLeaveTimeout={duration}>
      {show ? (
        <HtmlTag style={style} className={'container'} {...others} >
          {children}
        </HtmlTag>
      ) : null}
    </CSSTransitionGroup>
  );
}

/**类型检测**/
Fade.propTypes = {
  show: PropTypes.bool,
  duration: PropTypes.number,
  timingFunction: PropTypes.string,
  style: PropTypes.object,
  children: PropTypes.node
};

/**默认的属性**/
Fade.defaultProps = {
  show: false,
  duration: 80,
  timingFunction: 'ease',
  HtmlTag: 'div'
};
