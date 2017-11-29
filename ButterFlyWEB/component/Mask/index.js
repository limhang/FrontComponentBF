////////////////////////////////////////学习笔记]////////////////////////////////////////
/**这个组件比较简单，没有什么可以学习，可以巩固下之前所学到的，z-index，多个class做样式选择**/

////////////////////////////////////////组件简介////////////////////////////////////////
/**
  简介：通用的视图遮罩层
  依赖：暂无
  -- 被动输入端：
  * 1.在Mask控件包围范围内，做一些children控件的映射，或者说穿透
  -- 主动输出端：
  * 1.该组件没有点击消失这个属性，仔细想下，可以将主动显示和取消，放在外界做处理，用state作三目运算，刷新state时候决定该组件还在不在document上
**/

////////////////////////////////////////使用代码////////////////////////////////////////
/**
    <Mask transparent={true}>
      <div className="{'mask-div'}">
      <h1>show message</h1>
      </div>
    </Mask>
**/

////////////////////////////////////////源文件////////////////////////////////////////
import React from 'react';
import PropTypes from 'prop-types';
import './style.scss';
import {classNames} from '../utils';

export default function Mask (props) {
	//对于简单的组件，属性props是处理的核心，其中others是支持外界扩展，`others`是一个数组
  let {transparent, children, ...others} = props;
  let className = classNames('mask', {
    'mask-transparent': transparent
  });
  return (<div className={className} {...others}>{children}</div>);
}

//组件类型检查
Mask.propTypes = {
	transparent: PropTypes.bool,
	children: PropTypes.node
};