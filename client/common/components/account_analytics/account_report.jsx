import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import { withSettings } from 'atomic-fuel/libs/components/settings';
import { Trans } from 'react-i18next';
import * as AccountAnalyticsActions from '../../actions/account_analytics';


function select(state) {
  const { accountAnalytics  } = state;
  return {
    lms_account_id: state.settings.lms_account_id,
    months: accountAnalytics.stats.months,
    uniqueUsers: accountAnalytics.stats.uniqueUsers,
    studentSearches: accountAnalytics.stats.studentSearches,
    teacherSearches: accountAnalytics.stats.teacherSearches,
    courseSearches: accountAnalytics.stats.courseSearches,
    statsError: accountAnalytics.stats.error,
    shouldShowUniqueUsers: accountAnalytics.shouldShowUniqueUsers,
  };
}

export class AccountReport extends React.Component {

  static propTypes = {
    getUniqueUsers: PropTypes.func,
    tenant: PropTypes.string,
    lms_account_id: PropTypes.string,
    uniqueUsers: PropTypes.array,
    months: PropTypes.array,
    studentSearches: PropTypes.array,
    teacherSearches: PropTypes.array,
    courseSearches: PropTypes.array,
    statsError: PropTypes.string,
    shouldShowUniqueUsers: PropTypes.bool,
  };

  constructor(props) {
    super(props);
    this.state = {
      sortColumn: null,
      sortToggle: false,
      tableData: [],
    };
  }

  componentDidMount() {
    this.props.getUniqueUsers(this.props.lms_account_id, this.props.tenant);
  }

  setSortCol(index) {
    if (this.state.sortColumn === index) {
      this.setState((state) => ({
        sortToggle: !state.sortToggle,
      }));
    }
    else {
      this.setState({
        sortToggle: false,
        sortColumn: index,
      });
    }
  }

  sortClassName(index) {
    if (this.state.sortColumn === index) {
      return this.state.sortToggle ? 'is-asc': 'is-desc';
    }
    return '';
  }

  getSortedTableBody() {
    const sortedData = _.orderBy(this.makeTableData(), ({ data }) => data[this.state.sortColumn], this.state.sortToggle ? 'asc' : 'desc');

    return (
      <tbody>
        { _.map(sortedData, ({ type, data, show }, key) => {
          return(show && (
            <tr key={key}>
              <th><Trans>{type}</Trans></th>
              {_.map((data), (value, index) => <td key={index}>{value}</td>)}
            </tr>
          ));
        })}
      </tbody>
    );
  }

  addMaxToData(data) {
    return _.concat(_.max(data), data);
  }

  makeTableData() {
    const {
      uniqueUsers,
      teacherSearches,
      studentSearches,
      courseSearches,
    } = this.props;

    return [
      {
        type: 'Unique Users',
        data: this.addMaxToData(uniqueUsers),
        show: this.props.shouldShowUniqueUsers,
      },
      {
        type: 'Courses',
        data: this.addMaxToData(courseSearches),
        show: true,
      },
      {
        type: 'Teacher Searches',
        data: this.addMaxToData(teacherSearches),
        show: true,
      },
      {
        type: 'Student Searches',
        data: this.addMaxToData(studentSearches),
        show: true,
      },
    ];

  }

  render() {
    const { months, statsError } = this.props;

    if(statsError) {
      return statsError;
    }

    return (
      <div className="aj-table-border">
        <table className="aj-table--account-analytics">
          <thead>
            <tr>
              <th className="aj-sort-header" onClick={() => this.setState({ sortColumn: null })}>
                <Trans>Type</Trans>
              </th>
              {_.map(_.concat('Max', months), (month, index) => (
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
          {this.getSortedTableBody()}
        </table>
      </div>
    );
  }
}

export default withSettings(
  connect(select, AccountAnalyticsActions)(AccountReport)
);
