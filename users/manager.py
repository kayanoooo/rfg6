from PyQt6.QtWidgets import QTableWidgetItem, QMessageBox
from ui.manager_win import Ui_ManagerWindow
from users.base_window import BaseWindow
from database.db import all_orders, set_order_status
from datetime import datetime


class manager_window(BaseWindow, Ui_ManagerWindow):
    def __init__(self, full_name=''):
        super().__init__()
        self.setupUi(self)
        self.labelCurrentUser.setText(full_name or 'manager')

        self.pushButtonLogout.clicked.connect(self.back_to_login)
        self.pushButtonRefresh.clicked.connect(self.load_orders)
        self.pushButtonApplyStatus.clicked.connect(self.apply_status)

        self.load_orders()

    def load_orders(self):
        orders = all_orders()
        self._fill_tables(self.tableWidgetOrders, orders,
                        ['order_id', 'article', 'status', 'pickup_delivery', 
                        'order_date', 'delivery_date', 'total_amount'])

    def apply_status(self):
        """Применяет новый статус к выбранному заказу"""
        row = self.tableWidgetOrders.currentRow()
        if row < 0:
            QMessageBox.warning(self, 'Ошибка', 'Выберите заказ')
            return
        
        # Получаем ID заказа и новый статус
        order_id = int(self.tableWidgetOrders.item(row, 0).text())
        current_status = self.tableWidgetOrders.item(row, 2).text()
        new_status = self.comboNewStatus.currentText()
        
        # Проверяем, изменился ли статус
        if current_status == new_status:
            QMessageBox.information(self, 'Информация', f'Заказ уже имеет статус "{new_status}"')
            return
        
        # Подтверждение
        reply = QMessageBox.question(
            self, 
            'Подтверждение', 
            f'Изменить статус заказа #{order_id}\nс "{current_status}" на "{new_status}"?',
            QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No
        )
        
        if reply == QMessageBox.StandardButton.Yes:
            if set_order_status(order_id, new_status):
                self.load_orders()
                self.statusbar.showMessage(f'Заказ #{order_id} → "{new_status}"')
            else:
                QMessageBox.critical(self, 'Ошибка', 'Не удалось изменить статус заказа')