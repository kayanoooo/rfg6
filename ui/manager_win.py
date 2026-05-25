from PyQt6.QtWidgets import (
    QWidget, QLabel, QPushButton, QVBoxLayout, QHBoxLayout,
    QTableWidget, QComboBox, QStatusBar, QHeaderView
)
from ui.order_form import ORDER_STATUSES


class Ui_ManagerWindow:
    def setupUi(self, Window):
        Window.resize(1200, 700)
        Window.setWindowTitle('Пиццерия — Менеджер')

        self.centralwidget = QWidget(Window)
        Window.setCentralWidget(self.centralwidget)
        main = QVBoxLayout(self.centralwidget)

        top = QHBoxLayout()
        self.labelCurrentUser = QLabel('Менеджер')
        self.pushButtonLogout = QPushButton('Выйти')
        top.addWidget(QLabel('Управление заказами'))
        top.addStretch()
        top.addWidget(self.labelCurrentUser)
        top.addWidget(self.pushButtonLogout)
        main.addLayout(top)

        # Панель управления статусами
        status_layout = QHBoxLayout()
        status_layout.addWidget(QLabel('Изменить статус заказа:'))
        self.comboNewStatus = QComboBox()
        self.comboNewStatus.addItems(ORDER_STATUSES)
        self.pushButtonApplyStatus = QPushButton('Применить')
        self.pushButtonRefresh = QPushButton('Обновить')
        status_layout.addWidget(self.comboNewStatus)
        status_layout.addWidget(self.pushButtonApplyStatus)
        status_layout.addStretch()
        status_layout.addWidget(self.pushButtonRefresh)
        main.addLayout(status_layout)

        # Таблица заказов
        self.tableWidgetOrders = QTableWidget(0, 7)
        self.tableWidgetOrders.setHorizontalHeaderLabels([
            'ID', 'Артикул', 'Статус', 'Адрес', 'Дата заказа', 'Дата доставки', 'Сумма'
        ])
        self.tableWidgetOrders.setSelectionBehavior(QTableWidget.SelectionBehavior.SelectRows)
        self.tableWidgetOrders.setEditTriggers(QTableWidget.EditTrigger.NoEditTriggers)
        self.tableWidgetOrders.horizontalHeader().setSectionResizeMode(QHeaderView.ResizeMode.ResizeToContents)
        main.addWidget(self.tableWidgetOrders)

        self.statusbar = QStatusBar(Window)
        Window.setStatusBar(self.statusbar)