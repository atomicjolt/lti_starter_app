import React          from 'react';
import _              from 'lodash';
import AccountInstall from './account_install';
import CourseInstalls from './course_installs';
import Pagination     from './pagination';

const PAGE_SIZE = 10;

export default class InstallPane extends React.Component {
  static propTypes = {
    courses             : React.PropTypes.arrayOf(React.PropTypes.shape({})).isRequired,
    loadExternalTools   : React.PropTypes.func,
    applicationInstance : React.PropTypes.shape({}),
    canvasRequest       : React.PropTypes.func,
    loadingCourses      : React.PropTypes.shape({}),
    account             : React.PropTypes.shape({
      name         : React.PropTypes.string,
      installCount : React.PropTypes.number
    }),
  };

  constructor() {
    super();
    this.state = {
      currentPage  : 0,
      searchPrefix : '',
    };
  }

  componentDidMount() {
    if (!_.isEmpty(this.props.courses)) {
      this.loadExternalTools();
    }
  }

  componentDidUpdate(prevProps, prevState) {
    if ((prevState.currentPage !== this.state.currentPage) ||
       (_.isEmpty(prevProps.courses) && !_.isEmpty(this.props.courses)) ||
       (prevState.searchPrefix !== this.state.searchPrefix)
    ) {
      this.loadExternalTools();
    }
  }

  searchedCourses() {
    return _.filter(this.props.courses, course => (
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
    const searchedCourses = this.searchedCourses();
    const pageCount = _.ceil(searchedCourses.length / PAGE_SIZE);
    return (
      <div className="o-right">
        <AccountInstall
          account={this.props.account}
          accountInstalls={this.props.account ? this.props.account.installCount : null}
          applicationInstance={this.props.applicationInstance}
          canvasRequest={this.props.canvasRequest}
        />
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
          applicationInstance={this.props.applicationInstance}
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
}
