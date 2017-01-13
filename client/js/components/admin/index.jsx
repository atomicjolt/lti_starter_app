import React       from 'react';

export default class Home extends React.Component {

  render() {
    return (
      <div className="o-contain o-contain--full">

        <div className="c-info">
          <div className="c-title">
            <h1>LTI Applications</h1>
          </div>
          <div className="c-search">
            <input type="text" placeholder="Search..." />
            <i className="i-search" />
          </div>
        </div>

        <table className="c-table c-table--lti">
          <thead>
            <tr>
              <th><span>NAME</span></th>
              <th><span>INSTANCES</span></th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><a href="">Attendance</a></td>
              <td><span>3</span></td>
            </tr>
            <tr>
              <td><a href="">SCORM Player</a></td>
              <td><span>9</span></td>
            </tr>
            <tr>
              <td><a href="">Proctor Tool</a></td>
              <td><span>1</span></td>
            </tr>
          </tbody>
        </table>

      </div>
    );
  }
}
