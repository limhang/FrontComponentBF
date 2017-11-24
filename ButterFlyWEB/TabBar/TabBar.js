////////////////////////////////////////学习笔记////////////////////////////////////////


////////////////////////////////////////组件简介////////////////////////////////////////
/**
  简介：底部tabbar，包裹tabBarItem
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
import TabBarItem from './TabBarItem';

export default function TabBar(props) {
  let {
    //外观设置【颜色】
    barColor,
    lineColor,
    color,
    selectedColor,
    //设置外观【半透明】-- 布尔值
    translucent,
    //包裹的子类
    children,
    //类名，可支持半透明样式配置
    className,
    //一些回调函数
    ...others
  } = props;

  className = classNames('tab-bar', {
    'tab-bar-translucent': translucent
  });
  let barStyle = {
    backgroundColor: barColor
  };
  let lineStyle = {
    backgroundColor: lineColor
  };
  //这里这样写，其实还是有点诡异的，其实就将TabBar看成一个函数对象就好，我们使用TabBar.Item时候，是这样用的
  // <TabBar.Item
  //   selected={selectedIndex === 0}
  //   title='Home'
  //   onClick={() => {
  //     this.setState({
  //       selectedIndex: 0
  //     });
  //   }}>
  //   <h1>TabBar</h1>
  //   <p>发i哦剪发i熬剪发i道交法i都爱</p>
  //   <p>发i哦剪发i熬剪发i道交法i都爱</p>
  //   <p>发i哦剪发i熬剪发i道交法i都爱</p>
  //   <p>发i哦剪发i熬剪发i道交法i都爱</p>
  // </TabBar.Item>
  TabBar.Item = TabBarItem;

  return (
    <div className={className} {...others}>
      <div className={classNames('tab-bar-body')}>
        {children}
      </div>
      <footer style={barStyle}>
      //这个最上面的一条线
        <div style={lineStyle} />
        //遍历一下传递进来的子视图
        <ul>{children.map((child, index) => {
          let props = {...child.props};
          //现在我感觉return这个写法有点多余
          return (
            <Button
              key={index}
              color={color}
              selectedColor={selectedColor}
              {...props} />
          );
        })}</ul>
      </footer>
    </div>
  );
}

/**属性配置检测**/
TabBar.propTypes = {
  barColor: PropTypes.string,
  lineColor: PropTypes.string,
  color: PropTypes.string,
  selectedColor: PropTypes.string,
  translucent: PropTypes.bool
};

/**默认属性配置**/
TabBar.defaultProps = {
  barColor: '#f7f7fa',
  lineColor: '#979797',
  color: '#888',
  selectedColor: '#09bb07',
  translucent: false
};




function Button(props) {
  let {
    // from TabBar
    color, selectedColor,
    // from TabBarItem
    selected, icon, selectedIcon, title, badge, onClick, className, ...others
  } = props;
  className = classNames('tab-bar-item', {
    'tab-bar-item-selected': selected
  });
  let iconClass = (selected && selectedIcon) ? selectedIcon : icon;
  let style = {
    color: (selected ? selectedColor : color)
  };

  return (
    <li className={className} onClick={onClick} {...others}>
      <div className={classNames('tab-bar-item-label')}>
        <i className={iconClass} style={style} />
        {typeof badge !== 'undefined' ? (<span>{badge}</span>) : null}
      </div>
      <div className={classNames('tab-bar-item-title')} style={style}>
        {title}
      </div>
    </li>
  );
}

Button.propTypes = {
  // from TabBar
  color: TabBar.propTypes.color,
  selectedColor: TabBar.propTypes.selectedColor,
  // from TabBarItem 不包含 children
  ...TabBarItem.propTypes
};
