import React          from 'react';
import ReactPaginate  from 'react-paginate';
import AccountInstall from './account_install';
import CourseInstalls from './course_installs';

const PAGE_SIZE = 10;

export default class InstallPane extends React.Component {
  static propTypes = {
    account: React.PropTypes.shape({
      name: React.PropTypes.string,
      installCount: React.PropTypes.number
    }),
    courses: React.PropTypes.arrayOf(React.PropTypes.shape({})).isRequired,
  };

  constructor() {
    super();
    this.state = {
      currentPage: 0
    };
  }

  componentDidMount() {

  }

  componentDidUpdate(prevProps, prevState) {
    if (prevState.currentPage !== this.state.currentPage) {
      // this.loadExternalTools();
    }
  }

  loadExternalTools() {
    _.each(this.props.courses)
      this.props.loadExternalTools();
  }

  render() {
    const courses = _.slice(
      _.values(this.props.courses),
      this.state.currentPage * PAGE_SIZE,
      (this.state.currentPage * PAGE_SIZE) + 10
    )

    const pageCount = _.floor(_.keys(this.props.courses).length / PAGE_SIZE);

    return (
      <div className="o-right">
        <AccountInstall
          accountName={this.props.account ? this.props.account.name : 'Root'}
          accountInstalls={this.props.account ? this.props.account.installCount : null}
        />
        <div className="c-search c-search--small">
          <input type="text" placeholder="Search..." />
          <i className="i-search" />
        </div>
        <CourseInstalls courses={courses} />
        {
          this.props.courses.length > PAGE_SIZE ? <ReactPaginate
            previousLabel="Prev"
            containerClassName="pagination"
            pageCount={pageCount}
            pageRangeDisplayed={5}
            marginPagesDisplayed={1}
            onPageChange={change => this.setState({ currentPage: change.selected })}
          /> : null
        }
      </div>
    );
  }
}
