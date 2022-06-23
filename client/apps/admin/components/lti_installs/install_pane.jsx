import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import { useSelector } from 'react-redux';
import _ from 'lodash';
import AccountInstall from './account_install';
import CourseInstalls from './course_installs';
import Pagination from '../common/pagination';

const PAGE_SIZE = 10;

export default function InstallPane(props) {
  const {
    loadExternalTools: loadExternalToolsById,
    applicationInstance,
    canvasRequest,
    loadingCourses,
    account,
  } = props;

  const [currentPage, setCurrentPage] = useState(0);
  const [searchPrefix, setSearchPrefix] = useState('');
  const [onlyShowInstalled, setOnlyShowInstalled] = useState(false);

  const courses = useSelector((state) => state.courses);

  const pageCourses = (searchedCoursesVar) => _.slice(
    searchedCoursesVar,
    currentPage * PAGE_SIZE,
    (currentPage * PAGE_SIZE) + PAGE_SIZE
  );

  const filteredCourses = (coursesVar) => {
    if (onlyShowInstalled) {
      return _.filter(coursesVar, (course) => (
        _.find(
          course.external_tools,
          (tool) => tool.consumer_key === applicationInstance.lti_key
        )
      ));
    }
    return courses;
  };

  const filterCourses = () => {
    let tmpCourses;
    if (onlyShowInstalled) {
      tmpCourses = courses;
    } else {
      // Only show courses from the current account
      tmpCourses = _.filter(
        courses,
        (course) => account?.id === course.account_id
      );
    }

    return _.filter(filteredCourses(tmpCourses), (course) => (
      _.includes(
        _.lowerCase(course.name),
        _.lowerCase(searchPrefix)
      )
    ));
  };

  const loadExternalTools = () => {
    _.each(pageCourses(filterCourses()), (course) => {
      if (course.external_tools === undefined) {
        loadExternalToolsById(course.id);
      }
    });
  };

  // componentDidMount
  useEffect(() => {
    if (!_.isEmpty(courses)) {
      loadExternalTools();
    }
  });

  // componentDidUpdate
  useEffect(() => {
    loadExternalTools();
  }, [currentPage, courses, searchPrefix]);

  const isSearching = () => !_.isEmpty(searchPrefix);

  const searchedCourses = () => _.filter(filteredCourses(courses), (course) => (
    _.includes(
      _.lowerCase(course.name),
      _.lowerCase(searchPrefix)
    )
  ));

  const updateSearchPrefix = _.debounce((tmpSearchPrefix) => {
    setSearchPrefix(tmpSearchPrefix);
    setCurrentPage(0);
  }, 150);

  const searchedCoursesVar =  isSearching() ? searchedCourses() : filterCourses();
  const pageCount = _.ceil(searchedCoursesVar.length / PAGE_SIZE);
  let accountInstall = null;
  let courseInstalls = null;

  if (applicationInstance) {
    accountInstall = (
      <AccountInstall
        account={account}
        accountInstalls={account ? account.installCount : null}
        applicationInstance={applicationInstance}
        canvasRequest={canvasRequest}
      />
    );
    courseInstalls = (
      <div>
        <div className="c-search c-search--small">
          <input
            type="text"
            placeholder="Search..."
            onChange={(e) => updateSearchPrefix(e.target.value)}
          />
          <i className="i-search" />
        </div>
        {
          !_.isEmpty(loadingCourses)
            ? <div className="c-modal--error loading">
              <div className="c-loading-icon" />
              </div> : null
        }
        <CourseInstalls
          applicationInstance={applicationInstance}
          courses={pageCourses(searchedCourses)}
          loadingCourses={loadingCourses}
          canvasRequest={canvasRequest}
          onlyShowInstalledChanged={(e) => setOnlyShowInstalled(e.target.checked)}
        />
        <Pagination
          setPage={(change) => setCurrentPage(change.selected)}
          pageCount={pageCount}
          currentPage={currentPage}
        />
      </div>
    );
  }
  return (
    <div className="o-right">
      {accountInstall}
      {courseInstalls}
    </div>
  );

}

InstallPane.propTypes = {
  loadExternalTools: PropTypes.func,
  applicationInstance : PropTypes.shape({}),
  canvasRequest: PropTypes.func,
  loadingCourses: PropTypes.shape({}),
  account: PropTypes.shape({
    installCount: PropTypes.number
  }),
};
