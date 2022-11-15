import React from 'react';
import TestRenderer from 'react-test-renderer';

import Menu from './menu';

describe('Menu', () => {
  it('renders the Menu component', () => {
    const result = TestRenderer.create(
        <Menu>
          {(onClick, activeClass, isOpen, menuRef) => (
            <div className={activeClass} ref={menuRef}>
              <button
                onClick={onClick}
                type="button"
              >
                <i className="material-icons" aria-hidden="true">more_vert</i>
              </button>
              <div className={`${isOpen ? 'open' : 'closed'}`}></div>
            </div>
          )}
          </Menu>
    );
    expect(result).toMatchSnapshot();
  });
});
