import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { Link } from 'react-router3';
import _ from 'lodash';
import { Trans } from 'react-i18next';
import { withSettings } from 'atomic-fuel/libs/components/settings';
import SimplePagination from '../../../apps/atomic_search/components/common/simple_pagination';

import * as AccountAnalytics from '../../actions/account_analytics';
import Loader from '../common/atomicjolt_loader';

function select(state) {
  const { accountAnalytics } = state;
  return {
    courses: accountAnalytics.courses.data,
    error: accountAnalytics.courses.error,
    loading: accountAnalytics.courseSearchesLoading,
    canvasUrl: state.settings.canvas_url
  };
}

export class CourseReport extends React.Component {

  static propTypes = {
    getCatalystCourseSearches: PropTypes.func,
    courses: PropTypes.shape({
      months: PropTypes.array,
      rows: PropTypes.array,
      totalPages: PropTypes.number,
    }),
    error: PropTypes.string,
    loading: PropTypes.bool,
    canvasUrl: PropTypes.string,
  };

  constructor(props) {
    super(props);
    this.state = {
      sortColumn: 0,
      sortToggle: false,
      currentPage: 1,
    };
  }

  componentDidMount() {
    const { currentPage, sortColumn, sortToggle } = this.state;
    this.props.getCatalystCourseSearches(sortColumn, sortToggle ? 'asc' : 'desc', currentPage);
  }

  setPage = (page) => {
    const { sortColumn, sortToggle } = this.state;
    this.setState({ currentPage: page });
    this.props.getCatalystCourseSearches(sortColumn, sortToggle ? 'asc' : 'desc', page);
  }

  setSortCol(index) {
    const { sortColumn, sortToggle } = this.state;
    // current column selected
    if (sortColumn === index) {
      this.props.getCatalystCourseSearches(sortColumn, !sortToggle ? 'asc' : 'desc', 1);
      this.setState((state) => ({
        sortToggle: !state.sortToggle,
        currentPage: 1,
      }));
    }
    // new column selected
    else {
      this.props.getCatalystCourseSearches(index, 'desc', 1);
      this.setState({
        sortToggle: false,
        sortColumn: index,
        currentPage: 1,
      });
    }
  }

  sortClassName(index) {
    if (this.state.sortColumn === index) {
      return this.state.sortToggle ? 'is-asc': 'is-desc';
    }
    return '';
  }

  getTableBody(tableData) {
    return (
      <tbody>
        { _.map(tableData, ({ name, data, courseId }, key) => {
          return(
            <tr key={key}>
              <td className={courseId ? 'aj-link aj-course' : 'aj-course'}>
                {courseId ? <Link href={`${this.props.canvasUrl}/courses/${courseId}`} target="page">{name}</Link> : name}
              </td>
              {_.map((data), (value, index) => <td key={index}>{value}</td>)}
            </tr>
          );
        })}
      </tbody>
    );
  }

  render() {

    const { courses, error, loading } = this.props;

    if(error) {
      return error;
    }

    if(loading) {
      return <Loader />;
    }

    return (
      <>
        <div className="aj-table-border">
          <table className="aj-table--account-analytics">
            <thead>
              <tr>
                <th className="aj-sort-header" onClick={() => this.setSortCol('course-name')}>
                  <div className="aj-flex">
                    <Trans>Course</Trans>
                    <button className={`aj-btn--sort ${this.sortClassName('course-name')}`}>
                      <i className="material-icons">arrow_drop_up</i>
                      <i className="material-icons">arrow_drop_down</i>
                    </button>
                  </div>
                </th>
                {_.map(courses.months, (month, index) => (
                  <th className="aj-sort-header" key={index} onClick={() => this.setSortCol(index)}>
                    <div className="aj-flex">
                      <Trans>{month}</Trans>
                      <button className={`aj-btn--sort ${this.sortClassName(index)}`}>
                        <i className="material-icons">arrow_drop_up</i>
                        <i className="material-icons">arrow_drop_down</i>
                      </button>
                    </div>
                  </th>
                ))}
              </tr>
            </thead>
            {this.getTableBody(courses.rows)}
          </table>
        </div>
        <SimplePagination
          currentPage={this.state.currentPage}
          totalPages={courses.totalPages}
          prevPage={() => this.setPage(this.state.currentPage - 1)}
          nextPage={() => this.setPage(this.state.currentPage + 1)}
        />
      </>
    );
  }
}

export default withSettings(
  connect(
    select,
    AccountAnalytics,
  )(CourseReport)
);
