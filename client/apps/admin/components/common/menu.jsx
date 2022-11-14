import React from 'react';
import PropTypes from 'prop-types';

export default class Menu extends React.Component {

  static propTypes = {
    children: PropTypes.func.isRequired
  };

  constructor(props) {
    super(props);
    this.state = { menuOpen: false, justOpened: false };
    this.menuRef = React.createRef();
  }

  componentDidUpdate(prevProps, prevState) {
    if (this.state.menuOpen && !prevState.menuOpen) {
      window.addEventListener(this.eventName, this.closeMenu);
    }
  }

  componentWillUnmount() {
    window.removeEventListener(this.eventName, this.closeMenu);
  }

  get eventName() {
    return 'close-menu';
  }

  closeMenu = () => {
    if (!this.state.justOpened) {
      this.setState({ menuOpen: false });
      window.removeEventListener('close-menu', this.closeMenu);
    } else {
      this.setState({ justOpened: false });
    }
  }

  onClick = () => {
    this.setState({
      menuOpen: !this.state.menuOpen,
      justOpened: !this.state.menuOpen,
    });
  }

  render() {
    const { menuOpen } = this.state;
    const activeClass = menuOpen ? 'is-active' : '';

    return this.props.children(this.onClick, activeClass, menuOpen, this.menuRef);
  }
}
