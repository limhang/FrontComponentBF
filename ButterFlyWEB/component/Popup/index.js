////////////////////////////////////////学习笔记]////////////////////////////////////////
/**
  这种支持视图的显示和消失组件，一般都是通过控制组件显示为null还是正常显示控制的
 **/

////////////////////////////////////////组件简介////////////////////////////////////////
/**
  简介：比较常见的popup组件,支持4种不同的弹出方式
  依赖：react-transition-group第三方库
  -- 被动输入端：
  * 1.支持定义弹出的方式
  * 2.外界定义隐藏还是消失，所谓的消失就是刷新render然后设置document元素为null或者为正常显示
  * 3.支持定义显示children
  -- 主动输出端：
  * 1.主动将children视图的点击传出
**/

////////////////////////////////////////使用代码////////////////////////////////////////
/**
 <Popup
   show={this.state.show}
   onClick={this.showMsg}
   direction={'top'}>
   <h2>{'top'}</h2>
   <p>{'fjaio放假爱偶奇偶'}</p>
   <p>{'fjaio放假爱偶奇偶'}</p>
   <p>{'fjaio放假爱偶奇偶'}</p>
 </Popup>
**/

////////////////////////////////////////源文件////////////////////////////////////////
import React from 'react';
import PropTypes from 'prop-types';
import './style.scss';
import {classNames} from '../utils';
import { CSSTransitionGroup } from 'react-transition-group' // ES6

export default function Popup (props) {
	let {
	  show,
    duration,
    timingFunction,
    children,
    direction,
	  style,
    ...others
	} = props;
  let className = classNames('popup');
  style = {
    ...style,
    transitionDuration: (duration + 'ms'),
    transitionTimingFunction: timingFunction
  };
	return (
    <CSSTransitionGroup
      //使用该库常见的几个配置，这个容器的名字
      transitionName={'popup'}
      transitionEnterTimeout={duration}
      transitionLeaveTimeout={duration}>
      {show ? (
          <div className={className} style={style}>
            <div
              className={classNames('popup-main', `popup-main-${direction}`)}
              style={style}>
              <div {...others}>
                {children}
              </div>
            </div>
          </div>
        ) : null}
    </CSSTransitionGroup>
  )
}


//组件属性默认值
Popup.defaultProps = {
  show: false,
  duration: 400,
  timingFunction: 'ease',
  direction: 'bottom'
};

//组件类型检查
Popup.propTypes = {
  show: PropTypes.bool.isRequired,
  duration: PropTypes.number.isRequired,
  timingFunction: PropTypes.string.isRequired,
  direction: PropTypes.oneOf(['left', 'right', 'top', 'bottom']).isRequired,
  children: PropTypes.node.isRequired,
  className: PropTypes.string,
  style: PropTypes.object
};
