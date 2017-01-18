import React        from 'react';

export default class DropDownItem extends React.Component {
  static propTypes = {
    children  : React.PropTypes.node.isRequired,
    onClick   : React.PropTypes.func,
  };

  constructor() {
    super();
    this.state = { hovered: false };
  }

  getStyles() {
    return {
      listItem: {
        backgroundColor: this.state.hovered ? 'grey' : 'white',
      },
      button: {
        border          : 'none',
        backgroundColor : 'transparent',
        fontSize        : '1em',
        cursor          : 'pointer',
      }
    };
  }

  render() {
    const styles = this.getStyles();
    return (
      <li
        onMouseEnter={() => this.setState({ hovered: true })}
        onMouseLeave={() => this.setState({ hovered: false })}
        style={styles.listItem}
      >
        <button style={styles.button} onClick={this.props.onClick}>
          {this.props.children}
        </button>
      </li>
    );
  }
}