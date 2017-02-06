import React            from 'react';
import _                from 'lodash';
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
          <th />
        </tr>
      </thead>
      <tbody>
        {_.isEmpty(props.loadingCourses) ? courses : null}
      </tbody>
    </table>
  );
}

CourseInstalls.propTypes = {
  courses             : React.PropTypes.arrayOf(React.PropTypes.shape({})).isRequired,
  loadingCourses      : React.PropTypes.shape({}),
  // canvasRequest       : React.PropTypes.func,
  applicationInstance : React.PropTypes.shape({}),
};
