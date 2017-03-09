import React from 'react';

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
  text: React.PropTypes.string,
};
