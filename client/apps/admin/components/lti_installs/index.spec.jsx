import React from 'react';
import { shallow } from 'enzyme';
import { Index } from './index';

jest.mock('../../libs/assets');

describe('the index component', () => {
  let result;
  let props;
  let coursesRequested;

  beforeEach(() => {
    coursesRequested = false;
    props = {
      accounts: {},
      rootAccount: {
        id: 1234,
      },
      applications: {},
      courses: [{}],
      applicationInstance: {},
      loadingCourses: {},
      loadingAccounts: false,
      getApplicationInstance: () => {},
      canvasRequest: () => { coursesRequested = true; },
      saveApplicationInstance: () => {},
      params: {
        applicationId: 'application id',
        applicationInstanceId: 'application instance id',
      },
      sites: {},
    };
    result = shallow(<Index {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('calls the canvasRequest props function', () => {
    expect(coursesRequested).toBeFalsy();
    result.instance().loadExternalTools();
    expect(coursesRequested).toBeTruthy();
  });

  it('sets the active account', () => {
    result.instance().componentWillReceiveProps();
    expect(result.instance().state.currentAccount.id).toBe(1234)
  });
});
