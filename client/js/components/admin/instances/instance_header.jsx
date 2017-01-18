import React    from 'react';

export default function instanceHeader(props) {

  const styles = {
    buttonIcon: {
      border          : 'none',
      backgroundColor : 'transparent',
      color           : 'grey',
      fontSize        : '1em',
      cursor          : 'pointer',
    }
  };

  return (
    <div className="c-info">
      <div className="c-title">
        <h1>Instances</h1>
        <h3>Attendance
          <button style={styles.buttonIcon} onClick={props.openSettings}>
            <i className="i-settings" />
          </button>
        </h3>
      </div>
      <button className="c-btn c-btn--yellow" onClick={props.newInstance}>
        New Instance
      </button>
    </div>
  );
}

instanceHeader.propTypes = {
  openSettings : React.PropTypes.func.isRequired,
  newInstance  : React.PropTypes.func.isRequired,
};
