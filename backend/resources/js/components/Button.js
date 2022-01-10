import React from 'react';

export default function Button({ type = 'submit', className = '', processing, children }) {
    return (
        <button
            type={type}
            className={
                `inline-flex items-center justify-center px-6 py-4 bg-primary hover:bg-primary-400 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest active:bg-primary transition ease-in-out duration-150 ${
                    processing && 'opacity-25'
                } ` + className
            }
            disabled={processing}
        >
            {children}
        </button>
    );
}
