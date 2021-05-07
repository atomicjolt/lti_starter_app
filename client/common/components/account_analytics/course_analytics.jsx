import React from 'react';
import PropTypes from 'prop-types';
import CourseReport from './course_report';
import TopBar from './top_bar';


export default function CourseAnalytics(props) {
  const { router } = props;

  return (
    <div>
      <TopBar
        goBack={router.goBack}
        title="Atomic Search - Searches by Course"
      />
      <div className="aj-analytics-course">
        <CourseReport />
      </div>
    </div>
  );
}

CourseAnalytics.propTypes = {
  router: PropTypes.shape({
    goBack: PropTypes.func,
  }),
};

