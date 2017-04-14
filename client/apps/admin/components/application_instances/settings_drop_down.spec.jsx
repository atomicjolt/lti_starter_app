import React            from 'react';
import TestUtils        from 'react-dom/test-utils';
import Stub             from '../../../../specs_support/stub';
import SettingsDropDown from './settings_drop_down';

describe('application instance modal', () => {

  let result;

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Stub>
        <SettingsDropDown />
      </Stub>
    );
  });

  it('renders a list with settings', () => {
    const ul = TestUtils.findRenderedDOMComponentWithTag(result, 'ul');
    expect(ul.textContent).toContain('Settings');
  });

});
