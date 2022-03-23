import React from 'react';
import TestRenderer from 'react-test-renderer';
import { InstallPane } from './install_pane';

describe('install pane', () => {
  let result;
  let instance;
  let props;

  jest.useFakeTimers();
  beforeEach(() => {
    props = {
      canvasRequest: () => {},
      loadingCourses: {},
      applicationInstance: {},
      courses: {},
      account: {
        installCount: 0,
      },
      loadExternalTools: () => {},
      onlyShowInstalled: false,
      onlyShowInstalledChanged: () => {},
    };
    result = TestRenderer.create(<InstallPane {...props} />);
    instance = result.root;
  });

  it('renders the install pane with course installs for basic', () => {
    const input = instance.findByType('input');
    expect(input.props.placeholder).toContain('Search...');
  });

  it('handles the input change', () => {
    expect(result.root.state.searchPrefix).toEqual('');
    result.root.updateSearchPrefix = jest.fn();
    instance.findByType('input').simulate('change', { target: { value: 'Changed' } });
    expect(result.root.updateSearchPrefix).toBeCalled();
  });
});
