import React from 'react';
import PropTypes from 'prop-types';
import {classNames} from '../utils';
import './style.scss';

export default function IconLoading(props) {
  let {style,scale} = props;
  style = {
    ...style,
    transform: (`scale(${scale}`)
  };
  let leafs = createLeafs();
  return (
    <div className={'icon-loading'} style={style}>{leafs}</div>
  );
}

/**类型检查**/
IconLoading.propTypes = {
  scale: PropTypes.number,
  style: PropTypes.object
};

/**默认属性**/
IconLoading.defaultProps = {
  scale: 1
};

/**创建子视图**/
const count = 12;
const opacityUnit = 1 / (count + 13);

function createLeafs() {
  let leafs = [];
  let className, rotate, style;

  for (let i = 0; i < count; i++) {
    className = classNames('icon-loading-leaf', `icon-loading-leaf-${i}`);
    rotate = i * 30;
    style = {
      transform: (`rotate(${rotate}deg)`),
      opacity: (1 - opacityUnit * i)
    };
    leafs.push((<i key={i} className={className} style={style} />));
  }

  return leafs;
}
