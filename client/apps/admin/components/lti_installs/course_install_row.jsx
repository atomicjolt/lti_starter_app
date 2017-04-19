import React from 'react';
import PropTypes from 'prop-types';
import {
  createExternalToolCourses,
  deleteExternalToolCourses,
} from '../../../../libs/canvas/constants/external_tools';

export default function CourseInstallRow(props) {
  const {
    courseName,
    courseId,
    installedTool,
    canvasRequest,
    applicationInstance,
  } = props;

  function installInCourse() {
    if (installedTool) {
      canvasRequest(
        deleteExternalToolCourses,
        {
          course_id: courseId,
          external_tool_id: installedTool.id,
        },
        null,
        {
          courseId,
        },
      );
    } else {
      canvasRequest(
        createExternalToolCourses,
        {
          course_id: courseId,
        },
        {
          name: applicationInstance.name,
          consumer_key: applicationInstance.lti_key,
          shared_secret: applicationInstance.lti_secret,
          privacy_level: 'public',
          config_type: 'by_xml',
          config_xml: applicationInstance.lti_config_xml
        },
        {
          courseId,
        },
      );
    }
  }

  const installText = installedTool ? 'Uninstall' : 'Install';

  let courseUrl = `${applicationInstance.site.url}/courses/${courseId}`;
  if (installedTool) {
    courseUrl = `${courseUrl}/external_tools/${installedTool.id}`;
  }

  return (
    <tr>
      <td>
        <div className="c-table--inactive">
          <a href={courseUrl} target="_blank" rel="noopener noreferrer">
            {courseName}
          </a>
        </div>
      </td>
      <td>
        <button
          className="c-btn c-btn--gray"
          onClick={() => installInCourse(installedTool, courseId)}
        >
          {installText}
        </button>
      </td>
    </tr>
  );
}

CourseInstallRow.propTypes = {
  courseName: PropTypes.string.isRequired,
  canvasRequest: PropTypes.func.isRequired,
  courseId: PropTypes.number.isRequired,
  installedTool: PropTypes.shape({}),
  applicationInstance: PropTypes.shape({
    name: PropTypes.string,
    lti_key: PropTypes.string,
    lti_secret: PropTypes.string,
    lti_config_xml: PropTypes.string,
  }),
};
