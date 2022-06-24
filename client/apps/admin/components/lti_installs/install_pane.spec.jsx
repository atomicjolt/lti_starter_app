import React from 'react';
import ReactDOM from 'react-dom';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';
import ReactTestUtils, { act } from 'react-dom/test-utils';
import InstallPane from './install_pane';

const courses = {};
const mockStore = configureStore([]);
const store = mockStore({ courses });

describe('install pane', () => {
  let result;
  let instance;

  const canvasRequest = () => {};
  const loadingCourses = {};
  const applicationInstance = {};
  const account = {
    installCount: 0,
  };
  const loadExternalTools = () => {};
  const onlyShowInstalled = false;
  const onlyShowInstalledChanged = () => {};

  jest.useFakeTimers();
  beforeEach(() => {
    result = TestRenderer.create(
      <Provider store={store}>
        <InstallPane
          canvasRequest={canvasRequest}
          loadingCourses={loadingCourses}
          applicationInstance={applicationInstance}
          courses={courses}
          account={account}
          loadExternalTools={loadExternalTools}
          onlyShowInstalled={onlyShowInstalled}
          onlyShowInstalledChanged={onlyShowInstalledChanged}
        />
      </Provider>
    );
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('renders the install pane with course installs for basic', () => {
    const input = instance.findByType('input');
    expect(input.props.placeholder).toContain('Search...');
  });

  it('handles the input change', () => {
    const container = document.createElement('div');
    document.body.appendChild(container);
    act(() => {
      ReactDOM.render(
        <Provider store={store}>
          <InstallPane
            canvasRequest={canvasRequest}
            loadingCourses={loadingCourses}
            applicationInstance={applicationInstance}
            courses={courses}
            account={account}
            loadExternalTools={loadExternalTools}
            onlyShowInstalled={onlyShowInstalled}
            onlyShowInstalledChanged={onlyShowInstalledChanged}
          />
        </Provider>,
        container
      );
    });

    const inputs = document.getElementsByTagName('input');
    expect(inputs.length).toEqual(1);
    const input = inputs[0];
    input.value = 'test';
    ReactTestUtils.Simulate.change(input);
    expect(input.value).toEqual('test');
  });
});
