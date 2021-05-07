import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import LineGraph from './line_graph';
import i18n from '../../../libs/i18n';
import * as AccountAnalyticsActions from '../../actions/account_analytics';

function select(state) {
  const { accountAnalytics } = state;
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

export class Graph extends React.Component {
  static propTypes = {
    getUniqueUsers: PropTypes.func,
    tenant: PropTypes.string,
    lms_account_id: PropTypes.string,
    months: PropTypes.array,
    uniqueUsers: PropTypes.array,
    studentSearches: PropTypes.array,
    teacherSearches: PropTypes.array,
    courseSearches: PropTypes.array,
    statsError: PropTypes.string,
    shouldShowUniqueUsers: PropTypes.bool,
  };

  componentDidMount() {
    this.props.getUniqueUsers(this.props.lms_account_id, this.props.tenant);
  }


  getDataSets = (data) => {
    return _.map(data, (info) => (
      {
        label: info.label,
        fill: false,
        backgroundColor: 'rgba(75,192,192,0.4)',
        borderColor: info.lineColor,
        borderWidth: 2,
        borderCapStyle: 'butt',
        borderDash: [],
        borderDashOffset: 0.0,
        borderJoinStyle: 'miter',
        pointBorderColor: info.pointColor,
        pointBackgroundColor: info.pointColor,
        pointBorderWidth: 2,
        pointHoverRadius: 5,
        pointHoverBackgroundColor: info.color,
        pointHoverBorderColor: 'rgba(220,220,220,1)',
        pointHoverBorderWidth: 2,
        pointRadius: 2,
        pointHitRadius: 10,
        data: info.data,
      }
    ));
  }

  getOptions = () => ({
    maintainAspectRatio: false,
    legend: { display: false },
    scales: {
      yAxes:[{
        ticks: {
          beginAtZero: true,
          userCallback: label => (Math.floor(label) === label ? label : null),
        },
        gridLines: {
          display: true
        }
      }],
      xAxes:[{
        gridLines: {
          display: true
        },
      }],
    },
    layout: {
      padding: {
        top: 37,
      },
    },
  })

  getPlugins = (title) => ([{
    afterDraw: chart => {
      const { ctx } = chart.chart;
      ctx.save();
      ctx.textAlign = 'center';
      ctx.font = '14px Lato';
      ctx.fillStyle = '#333333';
      ctx.fillText(title, chart.chart.width / 2, 20);
      ctx.restore();
    }
  }])

  createLineGraphs = (data) => (
    _.map(data, ({ datasets, labels, title, show }, key) => {
      return (show &&
        <LineGraph
          key={key}
          plugins={this.getPlugins(i18n.t(title))}
          data={{ datasets, labels }}
          options={this.getOptions()}
        />
      );
    })
  )

  render() {

    const {
      months,
      teacherSearches,
      studentSearches,
      courseSearches,
      uniqueUsers,
      statsError,
    } = this.props;


    if(statsError) {
      return statsError;
    }

    const translatedMonths = _.map(months, (month) => i18n.t(month));

    const userSearchesInfo = [
      { label: i18n.t('Teacher Searches'), data: teacherSearches, lineColor: '#69E2FF', pointColor: '#01579B' },
      { label: i18n.t('Student Searches'), data: studentSearches, lineColor: '#45E2A0', pointColor: '#008E5D' },
    ];
    const courseGraphInfo = [
      { label: i18n.t('Course Searches'), data: courseSearches, lineColor: '#FFC069', pointColor: '#C17E02' }
    ];
    const uniqueUsersInfo = [
      { label: i18n.t('Unique Users'), data: uniqueUsers, lineColor: '#69E2FF', pointColor: '#01579B' }
    ];


    const graphData = [
      {
        labels: translatedMonths,
        datasets: this.getDataSets(uniqueUsersInfo),
        title:'Unique Users',
        show: this.props.shouldShowUniqueUsers,
      },
      {
        labels: translatedMonths,
        datasets: this.getDataSets(courseGraphInfo),
        title: 'Courses',
        show: true,
      },
      {
        labels: translatedMonths,
        datasets: this.getDataSets(userSearchesInfo),
        title:'Searches',
        show: true,
      },
    ];

    return (
      <div className="aj-flex aj-flex-graph">
        {this.createLineGraphs(graphData)}
      </div>
    );
  }
}

export default connect(select, AccountAnalyticsActions)(Graph);
