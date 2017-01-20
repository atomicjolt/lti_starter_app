import React        from 'react';
import assets       from '../../libs/assets';

export class Heading extends React.Component {
  render() {
    const img = assets('./images/atomicjolt.svg');
    return (
      <div style={{
        background: 'black',
        height: '50px',
        borderBottom: 'solid #EFC210 1px',
        display: 'block',
      }}>
        <h1 style={{
          textAlign: 'center',
          color: '#EFC210',
          paddingTop: '5px',
          paddingLeft: '20px',
        }}>
          <img src={img} alt="AtomicJolt Logo" height="40px" />
          <div style={{
            float: "right",
            paddingTop: '10px',
            paddingRight: '20px',
            color: 'lightgrey',
            fontFamily: 'Roboto, sans-serif',
          }} >
            pronto
          </div>
        </h1>
      </div>
    );
  }
}

export default (Heading);
