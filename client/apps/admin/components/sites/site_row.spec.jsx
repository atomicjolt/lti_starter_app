import React from 'react';
import ReactDOM from 'react-dom';
import TestRenderer, { act } from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';
import SiteRow from './site_row';

const mockStore = configureStore([]);
const store = mockStore({
  settings: {},
});

describe('sites list row', () => {
  let result;
  let instance;

  const site = { url: 'http://www.example.com' };
  const deleteSite = () => {};

  // https://medium.com/@amanverma.dev/mocking-create-portal-to-utilize-react-test-renderer-in-writing-snapshot-uts-c49773c88acd
  beforeAll(() => {
    ReactDOM.createPortal = jest.fn((element) => element);
  });

  afterEach(() => {
    ReactDOM.createPortal.mockClear();
  });

  beforeEach(() => {
    result = TestRenderer.create(
      <Provider store={store}>
        <SiteRow
          site={site}
          deleteSite={deleteSite}
        />
      </Provider>
    );
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the first button onclick event', () => {
    expect(result).toMatchSnapshot();
    const buttons = instance.findAllByType('button');
    act(() => {
      buttons[0].props.onClick();
    });
    expect(result).toMatchSnapshot();
  });

  it('handles the second button onclick event', () => {
    let buttons = instance.findAllByType('button');
    act(() => {
      buttons[1].props.onClick();
    });

    buttons = instance.findAllByType('button');
    const button = buttons.find((b) => b.children[0] === 'Cancel');
    expect(button).toBeTruthy();
  });
});
