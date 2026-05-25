from PyQt6.QtWidgets import (
    QDialog, QVBoxLayout, QGridLayout, QHBoxLayout,
    QLabel, QLineEdit, QPushButton, QSpinBox, QComboBox
)


class ItemFormDialog(QDialog):
    def __init__(self, parent):
        super().__init__(parent)
        self.setWindowTitle('Новый товар')
        self.resize(450, 450)

        main = QVBoxLayout(self)
        grid = QGridLayout()

        self.lineName         = QLineEdit()
        self.lineDesc         = QLineEdit()
        self.lineManufacturer = QLineEdit()
        self.lineSupplier     = QLineEdit()
        self.linePrice        = QLineEdit()
        self.lineCategory     = QLineEdit()
        self.spinQuantity     = QSpinBox()
        self.spinQuantity.setRange(0, 9999)
        self.spinQuantity.setValue(0)
        self.comboUnit        = QComboBox()
        self.comboUnit.addItems(['шт', 'кг', 'г', 'л', 'мл', 'порция'])

        row = 0
        grid.addWidget(QLabel('Наименование *'), row, 0)
        grid.addWidget(self.lineName, row, 1)
        row += 1
        
        grid.addWidget(QLabel('Описание'), row, 0)
        grid.addWidget(self.lineDesc, row, 1)
        row += 1
        
        grid.addWidget(QLabel('Производитель'), row, 0)
        grid.addWidget(self.lineManufacturer, row, 1)
        row += 1
        
        grid.addWidget(QLabel('Поставщик'), row, 0)
        grid.addWidget(self.lineSupplier, row, 1)
        row += 1
        
        grid.addWidget(QLabel('Категория'), row, 0)
        grid.addWidget(self.lineCategory, row, 1)
        row += 1
        
        grid.addWidget(QLabel('Цена *'), row, 0)
        grid.addWidget(self.linePrice, row, 1)
        row += 1
        
        grid.addWidget(QLabel('Единица измерения'), row, 0)
        grid.addWidget(self.comboUnit, row, 1)
        row += 1
        
        grid.addWidget(QLabel('Количество на складе'), row, 0)
        grid.addWidget(self.spinQuantity, row, 1)

        main.addLayout(grid)

        btns = QHBoxLayout()
        btns.addStretch()
        self.pushButtonSave   = QPushButton('Сохранить')
        self.pushButtonCancel = QPushButton('Отмена')
        btns.addWidget(self.pushButtonSave)
        btns.addWidget(self.pushButtonCancel)
        main.addLayout(btns)

        self.pushButtonSave.clicked.connect(self.accept)
        self.pushButtonCancel.clicked.connect(self.reject)

    def get_data(self):
        return (
            self.lineName.text().strip(),
            self.lineDesc.text().strip(),
            self.lineManufacturer.text().strip(),
            self.lineSupplier.text().strip(),
            self.linePrice.text().strip(),
            self.lineCategory.text().strip(),
            self.spinQuantity.value(),
            self.comboUnit.currentText(),
        )

    def validate(self):
        name, _, _, _, price, _, _, _ = self.get_data()
        if not name:
            return False, 'Введите наименование'
        try:
            float(price)
        except ValueError:
            return False, 'Цена должна быть числом'
        return True, ''