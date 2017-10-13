import React from 'react';
import { shallow } from 'enzyme';
import { InstallPane } from './install_pane';

describe('install pane', () => {
  let result;
  let props;

  jest.useFakeTimers();
  beforeEach(() => {
    props = {
      canvasRequest: () => {},
      loadingCourses: {},
      applicationInstance: {},
      courses: [],
      account: {
        installCount: 0,
      },
      loadExternalTools: () => {},
      onlyShowInstalled: false,
    };
    result = shallow(<InstallPane {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('renders the install pane with course installs for basic', () => {
    const input = result.find('input');
    expect(input.props().placeholder).toContain('Search...');
  });

  it('handles the input change', () => {
    expect(result.instance().state.searchPrefix).toEqual('');
    result.instance().updateSearchPrefix = jest.fn();
    result.find('input').simulate('change', { target: { value: 'Changed' } });
    expect(result.instance().updateSearchPrefix).toBeCalled();
  });
});
