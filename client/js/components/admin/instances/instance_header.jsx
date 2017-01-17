import React    from 'react';

export default function instanceHeader(props) {
  return (
    <div className="c-info">
      <div className="c-title">
        <h1>Instances</h1>
        <h3>Attendance <a href=""><i className="i-settings" /></a></h3>
      </div>
      <button className="c-btn c-btn--yellow">New Instance</button>
    </div>
  );
}

instanceHeader.propTypes = {

};
