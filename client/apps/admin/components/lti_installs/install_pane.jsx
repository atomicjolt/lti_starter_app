import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import AccountInstall from './account_install';
import CourseInstalls from './course_installs';
import Pagination from './pagination';

const PAGE_SIZE = 10;
const COURSE_TYPES = ['basic', 'course_navigation', 'wysiwyg_button'];

function select(state) {
  return {
    allCourses: state.courses,
  };
}

export class InstallPane extends React.Component {
  static propTypes = {
    courses             : PropTypes.arrayOf(PropTypes.shape({})).isRequired,
    loadExternalTools   : PropTypes.func,
    applicationInstance : PropTypes.shape({}),
    canvasRequest       : PropTypes.func,
    loadingCourses      : PropTypes.shape({}),
    account             : PropTypes.shape({
      installCount : PropTypes.number
    }),
    onlyShowInstalled: PropTypes.bool.isRequired,
  };

  constructor() {
    super();
    this.state = {
      currentPage: 0,
      searchPrefix: '',
    };
  }

  componentDidMount() {
    if (!_.isEmpty(this.props.courses)) {
      this.loadExternalTools();
    }
  }

  componentDidUpdate(prevProps, prevState) {
    if ((prevState.currentPage !== this.state.currentPage) ||
       (prevProps.courses.length !== this.props.courses.length) ||
       (prevState.searchPrefix !== this.state.searchPrefix)
    ) {
      this.loadExternalTools();
    }
  }

  isSearching() {
    return !_.isEmpty(this.state.searchPrefix);
  }

  filteredCourses(courses) {
    const {
      applicationInstance,
      onlyShowInstalled,
    } = this.props;

    if (onlyShowInstalled) {
      return _.filter(courses, course => (
        _.find(
          course.external_tools,
          tool => tool.consumer_key === applicationInstance.lti_key
        )
      ));
    }
    return courses;
  }

  searchedCourses() {
    const { allCourses } = this.props;
    return _.filter(this.filteredCourses(allCourses), course => (
      _.includes(
        _.lowerCase(course.name),
        _.lowerCase(this.state.searchPrefix)
      )
    ));
  }

  courses() {
    const { courses } = this.props;
    return _.filter(this.filteredCourses(courses), course => (
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
    _.each(this.pageCourses(this.searchedCourses()), (course) => {
      if (course.external_tools === undefined) {
        this.props.loadExternalTools(course.id);
      }
    });
  }

  updateSearchPrefix = _.debounce((searchPrefix) => {
    this.setState({ searchPrefix, currentPage: 0 });
  }, 150)

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
              onChange={e => this.updateSearchPrefix(e.target.value)}
            />
            <i className="i-search" />
          </div>
          {
            !_.isEmpty(this.props.loadingCourses) ?
              <div className="c-modal--error loading">
                <div className="c-loading-icon" />
              </div> : null
          }
          <CourseInstalls
            applicationInstance={applicationInstance}
            courses={this.pageCourses(searchedCourses)}
            loadingCourses={this.props.loadingCourses}
            canvasRequest={this.props.canvasRequest}
          />
          <Pagination
            setPage={change => this.setState({ currentPage: change.selected })}
            pageCount={pageCount}
            courses={this.props.courses}
            pageSize={PAGE_SIZE}
            loadingCourses={this.props.loadingCourses}
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

export default connect(select, {})(InstallPane);
