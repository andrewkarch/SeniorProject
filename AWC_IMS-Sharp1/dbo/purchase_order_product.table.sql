CREATE TABLE [dbo].[purchase_order_product]
(
	[pop_id] INT NOT NULL IDENTITY PRIMARY KEY, 
    [po_id] INT NOT NULL, 
    [product_id] INT NOT NULL, 
    [quantity] INT NOT NULL,
	FOREIGN KEY (po_id) REFERENCES purchase_order(po_id),
	FOREIGN KEY (product_id) REFERENCES product(product_id)
)