import React                     from 'react';
import {
  createExternalToolCourses,
  deleteExternalToolCourses,
} from '../../../libs/canvas/constants/external_tools';

export default function CourseInstallRow(props) {
  function installInCourse() {
    if (props.installedTool) {
      props.canvasRequest(
        deleteExternalToolCourses,
        { course_id: props.courseId, external_tool_id: props.installedTool.id },
        null,
        {
          courseId: props.courseId,
        },
      );
    } else {
      props.canvasRequest(
        createExternalToolCourses,
        { course_id: props.courseId },
        {
          name          : props.applicationInstance.name,
          consumer_key  : props.applicationInstance.lti_key,
          shared_secret : props.applicationInstance.lti_secret,
          privacy_level : 'public',
          config_type   : 'by_xml',
          config_xml    : props.applicationInstance.lti_config_xml
        },
        {
          courseId: props.courseId,
        },
      );
    }
  }

  const installText = props.installedTool ? 'Uninstall' : 'Install';

  return (
    <tr>
      <td><div className="c-table--inactive">{props.courseName}</div></td>
      <td>
        <button
          className="c-btn c-btn--gray"
          onClick={() => installInCourse(props.installedTool, props.courseId)}
        >
          {installText}
        </button>
      </td>
    </tr>
  );
}

CourseInstallRow.propTypes = {
  courseName          : React.PropTypes.string.isRequired,
  // canvasRequest       : React.PropTypes.func.isRequired,
  courseId            : React.PropTypes.number.isRequired,
  installedTool       : React.PropTypes.shape({}),
  // applicationInstance : React.PropTypes.shape({}),
};
