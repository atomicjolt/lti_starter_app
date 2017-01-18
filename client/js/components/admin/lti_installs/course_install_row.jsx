import React from 'react';

export default function CourseInstallRow(props) {
  const installText = props.isInstalled ? 'Uninstall' : 'Install';
  return (
    <tr>
      <td><a href="">{props.courseName}</a></td>
      <td><button className="c-btn c-btn--gray">{installText}</button></td>
    </tr>
  );
}

CourseInstallRow.propTypes = {
  courseName: React.PropTypes.string.isRequired,
  isInstalled: React.PropTypes.bool.isRequired
};
