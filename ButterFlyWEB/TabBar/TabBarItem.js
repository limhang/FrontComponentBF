////////////////////////////////////////学习笔记////////////////////////////////////////


////////////////////////////////////////组件简介////////////////////////////////////////
/**
  简介：底部tabbar的子元素，具体的内容不多，其实只是一个空壳，里面的东西都是外界给的
  依赖：暂无
  -- 被动输入端：
  * 1.style属性，可配置最外层view的显示
  * 2.children属性，可配置遮罩层上的view
  -- 主动输出端：
  * 1.others属性，支持点击视图，回调函数
**/


////////////////////////////////////////使用示例////////////////////////////////////////



////////////////////////////////////////源代码////////////////////////////////////////
import React from 'react';
import PropTypes from 'prop-types';
import {classNames,createInstance} from '../utils';

export default function TabBarItem(props) {
  //children是react提供的属性，可以获取到包裹在该组件[自己]下的元素
  //selected布尔值，提供给classname，点击后的样式设置
  const {selected, children} = props;
  let className = classNames('tab-bar-item', {
    'tab-bar-item-selected': selected
  });

  return (
    <div className={className}>{children}</div>
  );
}

/**属性约束**/
TabBarItem.propTypes = {
  children: PropTypes.node,
  selected: PropTypes.bool,
  icon: PropTypes.string,
  selectedIcon: PropTypes.string,
  title: PropTypes.string,
  badge: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number
  ]),
  onClick: PropTypes.func,
  className: PropTypes.string
};
