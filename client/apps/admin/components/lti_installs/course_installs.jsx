import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import CourseInstallRow from './course_install_row';

export default function CourseInstalls(props) {
  const { courses } = props;
  const { applicationInstance } = props;
  const { canvasRequest } = props;
  const { loadingCourses } = props;

  const installedCourses = _.map(courses, (course) => {
    const installedTool = _.find(
      course.external_tools,
      (tool) => tool.consumer_key === applicationInstance.lti_key
    );

    return (
      <CourseInstallRow
        key={course.id}
        courseName={course.name}
        courseId={course.id}
        installedTool={installedTool}
        canvasRequest={canvasRequest}
        applicationInstance={applicationInstance}
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
              {/* Removed for now. In order to show only the installs we have to load
                the external tools for all courses which ends up being hundreds of API calls.
              <input
                type="checkbox"
                id="onlyShowInstalled"
                name="onlyShowInstalled"
                onChange={props.onlyShowInstalledChanged}
              />
              <label htmlFor="onlyShowInstalled">Show only installed</label> */}
            </div>
          </th>
        </tr>
      </thead>
      <tbody>
        {_.isEmpty(loadingCourses) ? installedCourses : null}
      </tbody>
    </table>
  );
}

CourseInstalls.propTypes = {
  courses: PropTypes.arrayOf(PropTypes.shape({})).isRequired,
  loadingCourses: PropTypes.shape({}),
  applicationInstance: PropTypes.shape({}),
  // onlyShowInstalledChanged: PropTypes.func.isRequired,
};
