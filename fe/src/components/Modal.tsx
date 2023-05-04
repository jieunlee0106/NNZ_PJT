interface BtnProps {
  modalOpen: boolean;
  onClose: () => void;
}

function Modal({ modalOpen, onClose }: BtnProps) {
  return (
    <div className="fixed h-screen w-full flex justify-center items-center overflow-y-auto overflow-x-hidden outline-none bg-black bg-opacity-70 text-center">
      <div className="bg-white rounded w-2/5 md:w-1/3">
        <div className="boder-b px-4 py-2 flex justify-between items-center">
          <p>알림</p>
          <span onClick={onClose}>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={1.5}
              stroke="currentColor"
              className="w-6 h-6"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M9.75 9.75l4.5 4.5m0-4.5l-4.5 4.5M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
              />
            </svg>
          </span>
        </div>
        <div className="text-[#0d0d0d] text-sm px-4 py-8">
          진짜 거절하시나요?
        </div>
        <div className="flex justify-center items-center w-full border-t p-3 text-gray-500">
          <button
            onClick={onClose}
            className="bg-gray-600 hover:bg-gray-700 px-3 py-1 rounded text-white mx-1"
          >
            네
          </button>
          <button
            onClick={onClose}
            className="bg-gray-600 hover:bg-gray-700 px-3 py-1 rounded text-white mx-1"
          >
            아니요
          </button>
        </div>
      </div>
    </div>
  );
}

export default Modal;
