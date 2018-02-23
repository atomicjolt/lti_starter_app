import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import CourseInstallRow from './course_install_row';

export default function CourseInstalls(props) {
  const courses = _.map(props.courses, (course) => {
    const installedTool = _.find(
      course.external_tools,
      tool => tool.consumer_key === props.applicationInstance.lti_key
    );

    return (
      <CourseInstallRow
        key={course.id}
        courseName={course.name}
        courseId={course.id}
        installedTool={installedTool}
        canvasRequest={props.canvasRequest}
        applicationInstance={props.applicationInstance}
      />
    );
  });

  return (
    <table className="c-table c-table--installs">
      <thead>
        <tr>
          <th><span>Course Name</span></th>
          <th>
            <div className="c-checkbox--right-titlebar">
              <input
                type="checkbox"
                id="onlyShowInstalled"
                name="onlyShowInstalled"
                onChange={props.onlyShowInstalledChanged}
              />
              <label htmlFor="onlyShowInstalled">Show only installed</label>
            </div>
          </th>
        </tr>
      </thead>
      <tbody>
        {_.isEmpty(props.loadingCourses) ? courses : null}
      </tbody>
    </table>
  );
}

CourseInstalls.propTypes = {
  courses: PropTypes.arrayOf(PropTypes.shape({})).isRequired,
  loadingCourses: PropTypes.shape({}),
  applicationInstance: PropTypes.shape({}),
  onlyShowInstalledChanged: PropTypes.func.isRequired,
};
