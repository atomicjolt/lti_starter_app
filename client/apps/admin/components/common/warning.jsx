import React from 'react';
import PropTypes from 'prop-types';

export default function Warning(props) {
  const styles = {
    warning: {
      color: 'red',
    },
  };

  return (
    <div style={styles.warning}>
      Warning! Bad JSON! {props.text}
    </div>
  );
}

Warning.propTypes = {
  text: PropTypes.string,
};
