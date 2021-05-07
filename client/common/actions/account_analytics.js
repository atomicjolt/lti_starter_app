import wrapper from 'atomic-fuel/libs/constants/wrapper';
import Network from 'atomic-fuel/libs/constants/network';
import moment from 'moment';

const actions = [];
const requests = [
  'GET_UNIQUE_USERS',
  'GET_CATALYST_USER_SEARCHES',
  'GET_CATALYST_COURSE_SEARCHES',
];

export const Constants = wrapper(actions, requests);


export function getUniqueUsers(accountId, tenant) {
  if (accountId === '1' || tenant) {
    return {
      type: Constants.GET_UNIQUE_USERS,
      method: Network.GET,
      url: '/api/account_analytics/',
      isRoot: true,
      params:{
        tenant
      }
    };
  }
  return {
    type: Constants.GET_UNIQUE_USERS,
    isRoot: false,
  };
}

export function getCatalystUserSearches() {
  return {
    type: Constants.GET_CATALYST_USER_SEARCHES,
    startMonth: moment().subtract(12, 'months'),
    endMonth: moment(),
  };
}

export function getCatalystCourseSearches(
  sortColumnNum,
  sortDirection,
  pageNumber,
  pageSize = 10,
  startMonth = moment().subtract(12, 'months'),
  endMonth = moment()
) {

  const sortColumn = sortColumnNum === 'course-name' ? (
    'course-name'
  ) : (
    moment(endMonth).subtract(sortColumnNum, 'months').format('YYYY-MM')
  );

  return {
    type: Constants.GET_CATALYST_COURSE_SEARCHES,
    startMonth,
    endMonth,
    sortColumn,
    sortDirection,
    pageNumber,
    pageSize,
  };
}
