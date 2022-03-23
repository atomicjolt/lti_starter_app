import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import AccountInstall from './account_install';
import CourseInstalls from './course_installs';
import Pagination from '../common/pagination';

const PAGE_SIZE = 10;

function select(state) {
  return {
    courses: state.courses,
  };
}

export class InstallPane extends React.Component {
  constructor() {
    super();
    this.state = {
      currentPage: 0,
      searchPrefix: '',
      onlyShowInstalled: false,
    };
  }

  componentDidMount() {
    if (!_.isEmpty(this.props.courses)) {
      this.loadExternalTools();
    }
  }

  componentDidUpdate(prevProps, prevState) {
    if ((prevState.currentPage !== this.state.currentPage)
      || (prevProps.courses?.length !== this.props.courses?.length)
      || (prevState.searchPrefix !== this.state.searchPrefix)
    ) {
      this.loadExternalTools();
    }
  }

  isSearching() {
    return !_.isEmpty(this.state.searchPrefix);
  }

  filteredCourses(courses) {
    if (this.state.onlyShowInstalled) {
      return _.filter(courses, (course) => (
        _.find(
          course.external_tools,
          (tool) => tool.consumer_key === this.props.applicationInstance.lti_key
        )
      ));
    }
    return courses;
  }

  searchedCourses() {
    const { courses } = this.props;
    return _.filter(this.filteredCourses(courses), (course) => (
      _.includes(
        _.lowerCase(course.name),
        _.lowerCase(this.state.searchPrefix)
      )
    ));
  }

  courses() {
    let courses;
    if (this.state.onlyShowInstalled) {
      courses = this.props.courses;
    } else {
      // Only show courses from the current account
      courses = _.filter(
        this.props.courses,
        (course) => this.props.account?.id === course.account_id
      );
    }

    return _.filter(this.filteredCourses(courses), (course) => (
      _.includes(
        _.lowerCase(course.name),
        _.lowerCase(this.state.searchPrefix)
      )
    ));
  }

  pageCourses(searchedCourses) {
    return _.slice(
      searchedCourses,
      this.state.currentPage * PAGE_SIZE,
      (this.state.currentPage * PAGE_SIZE) + PAGE_SIZE
    );
  }

  loadExternalTools() {
    _.each(this.pageCourses(this.courses()), (course) => {
      if (course.external_tools === undefined) {
        this.props.loadExternalTools(course.id);
      }
    });
  }

  updateSearchPrefix = _.debounce((searchPrefix) => {
    this.setState({ searchPrefix, currentPage: 0 });
  }, 150);

  render() {
    const searchedCourses =  this.isSearching() ? this.searchedCourses() : this.courses();
    const pageCount = _.ceil(searchedCourses.length / PAGE_SIZE);
    let accountInstall = null;
    let courseInstalls = null;
    const {
      applicationInstance,
    } = this.props;

    if (applicationInstance) {
      accountInstall = (
        <AccountInstall
          account={this.props.account}
          accountInstalls={this.props.account ? this.props.account.installCount : null}
          applicationInstance={applicationInstance}
          canvasRequest={this.props.canvasRequest}
        />
      );
      courseInstalls = (
        <div>
          <div className="c-search c-search--small">
            <input
              type="text"
              placeholder="Search..."
              onChange={(e) => this.updateSearchPrefix(e.target.value)}
            />
            <i className="i-search" />
          </div>
          {
            !_.isEmpty(this.props.loadingCourses)
              ? <div className="c-modal--error loading">
                <div className="c-loading-icon" />
                </div> : null
          }
          <CourseInstalls
            applicationInstance={applicationInstance}
            courses={this.pageCourses(searchedCourses)}
            loadingCourses={this.props.loadingCourses}
            canvasRequest={this.props.canvasRequest}
            onlyShowInstalledChanged={(e) => this.setState({ onlyShowInstalled: e.target.checked })}
          />
          <Pagination
            setPage={(change) => this.setState({ currentPage: change.selected })}
            pageCount={pageCount}
            currentPage={this.state.currentPage}
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

export default connect(select, {})(InstallPane);
