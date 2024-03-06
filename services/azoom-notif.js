const data = [
  {
    id: "dhdhdhdhueud1",
    cc: "",
    sendingStatus: false,
    subject: "Test",
    textContent: "Demo",
    sendingDate: "",
    source: "cpo",
    isActive: 1,
    htmlContent: "",
    createdAt: "2024-03-06 12:15:10",
    senderName: "",
    senderEmail: "no-reply@azoom.jp",
    xMessageIds: ["23456789dttsts"],
    executedStaff: "org-11@gmail.com",
    updatedAt: "2024-03-06 12:15:10",
    recipients: [
      {
        recipientId: "TH90KdN29tMEn4V2XeOQ",
        email: "contractor-1@gmail.com",
        emails: [
          {
            contactUserStatus: false,
            contactAt: "",
            email: "tarou-0607@azoom.jp",
            contactStaffName: "Contractor 1",
          },
        ],
        attributes: [
          {
            label: "契約ID",
            value: 1,
            key: "contractId",
          },
          {
            label: "名前",
            value: "テスト 太郎",
            key: "name",
          },
          {
            label: "住所",
            value: "東京都渋谷区代々木1-1-2",
            key: "address",
          },
        ],
        latestEvent: {},
      },
    ],
  },
  {
    id: "dhdhdhdhueud2",
    cc: "",
    sendingStatus: false,
    subject: "Test",
    textContent: "Demo",
    sendingDate: "",
    source: "cpo",
    isActive: 1,
    htmlContent: "",
    createdAt: "2024-03-06 12:15:10",
    senderName: "",
    senderEmail: "no-reply@azoom.jp",
    xMessageIds: ["23456789dttsts"],
    executedStaff: "org-12@gmail.com",
    updatedAt: "2024-03-06 12:15:10",
    recipients: [
      {
        recipientId: "TH90KdN29tMEn4V2XeOQ",
        email: "contractor-1@gmail.com",
        emails: [
          {
            contactUserStatus: false,
            contactAt: "",
            email: "tarou-0607@azoom.jp",
            contactStaffName: "Contractor 1",
          },
        ],
        attributes: [
          {
            label: "契約ID",
            value: 1,
            key: "contractId",
          },
          {
            label: "名前",
            value: "テスト 太郎",
            key: "name",
          },
          {
            label: "住所",
            value: "東京都渋谷区代々木1-1-2",
            key: "address",
          },
        ],
        latestEvent: {},
      },
    ],
  },
  {
    id: "dhdhdhdhueud2",
    cc: "",
    sendingStatus: false,
    subject: "Test",
    textContent: "Demo",
    sendingDate: "",
    source: "cpo",
    isActive: 1,
    htmlContent: "",
    createdAt: "2024-03-06 12:15:10",
    senderName: "",
    senderEmail: "no-reply@azoom.jp",
    xMessageIds: ["23456789dttsts"],
    executedStaff: "org-12@gmail.com",
    updatedAt: "2024-03-06 12:15:10",
    recipients: [
      {
        recipientId: "TH90KdN29tMEn4V2XeOQ",
        email: "contractor-2@gmail.com",
        emails: [
          {
            contactUserStatus: false,
            contactAt: "",
            email: "tarou-0607@azoom.jp",
            contactStaffName: "Contractor 2",
          },
        ],
        attributes: [
          {
            label: "契約ID",
            value: 2,
            key: "contractId",
          },
          {
            label: "名前",
            value: "テスト 太郎",
            key: "name",
          },
          {
            label: "住所",
            value: "東京都渋谷区代々木1-1-2",
            key: "address",
          },
        ],
        latestEvent: {},
      },
    ],
  },
]
function getHistories() {
  return data
}

function getHistoryById(id) {
  return data.find((item) => item.id === id)
}

export { getHistories, getHistoryById }
