import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import { Chart, registerables } from 'chart.js';
import LineGraph from './line_graph';
import * as AccountAnalyticsActions from '../../actions/account_analytics';

Chart.register(...registerables);

function select(state) {
  const { accountAnalytics } = state;
  return {
    lms_account_id: state.settings.lms_account_id,
    uniqueUsers: accountAnalytics.stats.uniqueUsers,
    shouldShowUniqueUsers: accountAnalytics.shouldShowUniqueUsers,
    months: accountAnalytics.stats.months
  };
}

export class Graph extends React.Component {
  static propTypes = {
    getUniqueUsers: PropTypes.func,
    tenant: PropTypes.string,
    lms_account_id: PropTypes.string,
    uniqueUsers: PropTypes.array,
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
      yAxes:{
        ticks: {
          beginAtZero: true,
          userCallback: (label) => (Math.floor(label) === label ? label : null),
        },
        gridLines: {
          display: true
        }
      },
      xAxes:{
        gridLines: {
          display: true
        },
      },
    },
    layout: {
      padding: {
        top: 37,
      },
    },
  })

  getPlugins = (title) => ([{
    afterDraw: (chart) => {
      const { ctx } = chart;
      ctx.save();
      ctx.textAlign = 'center';
      ctx.font = '14px Lato';
      ctx.fillStyle = '#333333';
      ctx.fillText(title, chart.width / 2, 20);
      ctx.restore();
    }
  }])

  render() {

    const {
      months,
      uniqueUsers,
      statsError,
    } = this.props;


    if (statsError) {
      return statsError;
    }

    const translatedMonths = _.map(months, (month) => month);

    const uniqueUsersInfo = [
      { label: 'Unique Users', data: uniqueUsers, lineColor: '#69E2FF', pointColor: '#01579B' }
    ];


    const graphData = [
      {
        labels: translatedMonths,
        datasets: this.getDataSets(uniqueUsersInfo),
        title:'Unique Users',
        show: this.props.shouldShowUniqueUsers,
      },
    ];

    return (
      <div className="aj-flex aj-flex-graph">
        {_.map(graphData, ({ datasets, labels, title, show }, key) => {
          return (show &&
            <LineGraph
              key={key}
              plugins={this.getPlugins(title)}
              data={{ datasets, labels }}
              options={this.getOptions()}
            />
          );
        })}
      </div>
    );
  }
}

export default connect(select, AccountAnalyticsActions)(Graph);
