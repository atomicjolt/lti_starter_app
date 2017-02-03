import React from 'react';

export default function CourseInstallRow(props) {
  // find out if it is the correct tool installed
  // matching on the lti_secret of the tool.
  const installText = props.isInstalled ? 'Uninstall' : 'Install';
  // props.canvasRequest("LIST_EXTERNAL_TOOLS_COURSES", { course_id: course.id });
  return (
    <tr>
      <td><div className="c-table--inactive">{props.courseName}</div></td>
      <td><button className="c-btn c-btn--gray">{installText}</button></td>
    </tr>
  );
}

CourseInstallRow.propTypes = {
  courseName: React.PropTypes.string.isRequired,
  external_tools: React.PropTypes.bool
};
