import React from 'react';

type ButtonProps = {
  title: string;
  onClick: () => void;
};
export function Button({title, onClick}: ButtonProps) {
  return (
    <button type="button" onClick={onClick}>
      {title}
    </button>
  );
}
export default Button;
