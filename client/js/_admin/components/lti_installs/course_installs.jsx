import React            from 'react';
import _                from 'lodash';
import CourseInstallRow from './course_install_row';

export default function CourseInstalls(props) {
  const courses = _.map(props.courses, (course) => {
    return <CourseInstallRow key={course.id} courseName={course.name} isInstalled={course.external_tools} />;
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
        {courses}
      </tbody>
    </table>
  );
}

CourseInstalls.propTypes = {
  courses: React.PropTypes.arrayOf(
    React.PropTypes.shape({
      name: React.PropTypes.string,
      installed: React.PropTypes.bool
    })
  ).isRequired
};
