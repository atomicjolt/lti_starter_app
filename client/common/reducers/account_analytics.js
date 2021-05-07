import _ from 'lodash';
import moment from 'moment';
import { Constants } from '../actions/account_analytics';

const initialState = {
  stats: {
    months: [],
    uniqueUsers: [],
    studentSearches: [],
    teacherSearches: [],
  },
  courses: {
    data:{
      months:[],
      rows:[],
    },
  },
  startMonth: null,
  endMonth: null,
  userSearchesLoading: false,
  userSearchesLoaded: false,
  courseSearchesLoading: false,
  shouldShowUniqueUsers: true,
};

export default (state = initialState, action) => {
  let newState = {};
  let searches = {};

  switch (action.type) {
    case Constants.GET_UNIQUE_USERS:
      newState = _.cloneDeep(state);
      if (!action.isRoot) {
        newState.shouldShowUniqueUsers = false;
      }
      return newState;

    case Constants.GET_UNIQUE_USERS_DONE: {
      newState = _.cloneDeep(state);
      const { unique_users: uniqueUsers, months } = action.response.body;
      if (_.isEmpty(uniqueUsers)) {
        newState.shouldShowUniqueUsers = false;
        return newState;
      }

      newState.stats.uniqueUsers = uniqueUsers;
      newState.stats.months = months;
      return newState;
    }
    case Constants.GET_CATALYST_USER_SEARCHES:
      newState = _.cloneDeep(state);
      newState.startMonth = action.startMonth;
      newState.endMonth = action.endMonth;
      newState.userSearchesLoading = true;
      return newState;

    case Constants.GET_CATALYST_USER_SEARCHES_DONE:
      newState = _.cloneDeep(state);
      newState.userSearchesLoading = false;
      newState.userSearchesLoaded = true;
      if (_.isEmpty(action.error)) {
        const { body } = action.response;

        searches = {
          student:[],
          instructor:[],
          courses:[],
          months:[],
        };

        const { startMonth, endMonth } = newState;

        const monthStartRange = moment().diff(endMonth, 'months');
        const monthEndRange = endMonth.diff(startMonth, 'months') + monthStartRange;

        _.forEach(_.range(monthStartRange, monthEndRange), (num) => {
          const date = moment().subtract(num, 'months');

          searches.months.push(date.format('MMM'));
          searches.student.push(body.student[date.format('YYYY-MM')] || 0);
          searches.instructor.push(body.instructor[date.format('YYYY-MM')] || 0);
          searches.courses.push(body.courses[date.format('YYYY-MM')] || 0);
        });

        newState.stats.studentSearches = searches.student;
        newState.stats.teacherSearches = searches.instructor;
        newState.stats.courseSearches = searches.courses;
        newState.stats.months = searches.months;
        return newState;
      }

      newState.stats.studentSearches = null;
      newState.stats.teacherSearches = null;
      newState.stats.courseSearches = null;
      newState.stats.error = action.error;
      return newState;

    case Constants.GET_CATALYST_COURSE_SEARCHES:
      newState = _.cloneDeep(state);
      newState.startMonth = action.startMonth;
      newState.endMonth = action.endMonth;
      newState.courseSearchesLoading = true;
      return newState;

    case Constants.GET_CATALYST_COURSE_SEARCHES_DONE:
      newState = _.cloneDeep(state);
      newState.courseSearchesLoading = false;

      if (_.isEmpty(action.error)) {
        const { results, total_pages: totalPages } = action.response.body;
        const { startMonth, endMonth } = newState;
        const months = [];
        const rows = [];
        _.forEach(results, (info) => {
          rows.push({
            name: info.name,
            courseId: info.course_id,
            data: [],
          });
        });

        const monthStartRange = moment().diff(endMonth, 'months');
        const monthEndRange = endMonth.diff(startMonth, 'months') + monthStartRange;
        _.forEach(_.range(monthStartRange, monthEndRange), (num) => {
          const date = moment().subtract(num, 'months');
          months.push(date.format('MMM'));
          const yearMonth = date.format('YYYY-MM');
          _.forEach(results, (info, index) => {
            rows[index].data.push(info.searches[yearMonth] || 0);
          });
        });

        newState.courses.data = {
          months,
          rows,
          totalPages,
        };
        return newState;
      }

      newState.courses.data = null;
      newState.courses.error = action.error;
      return newState;

    default:
      return state;
  }
};
