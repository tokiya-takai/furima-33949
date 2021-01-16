# データベース設計

## users テーブル

|      Column      | Type   |   Options   |
| ---------------- | ------ | ----------- |
|       name       | string | null: false |
|       email      | string | null: false |
|     password     | string | null: false |
|    family_name   | string | null: false |
|    first_name    | string | null: false |
| family_name_kana | string | null: false |
| first_name_kana  | string | null: false |
|     birthday     | string | null: false |

### Association

- has_many :items
- has_many :orders

## items テーブル

|  Column   |    Type    |   Options                      |
| --------- | ---------- | ------------------------------ |
|   image   | string     | null: false                    |
|   title   | string     | null: false                    |
|  content  | string     | null: false                    |
|  category | string     | null: false                    |
|  status   | string     | null: false                    |
|   place   | string     | null: false                    |
|    days   | string     | null: false                    |
|   price   | integer    | null: false                    |
|  user_id  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

|  Column   |    Type    |   Options                      |
| --------- | ---------- | ------------------------------ |
|   token   | string     | null: false                    |
|   price   | integer    | null: false                    |
|  user_id  | references | null: false, foreign_key: true |
|  item_id  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :item
- has_one :address

## addresses テーブル

|      Column     |    Type    |   Options                      |
| --------------- | ---------- | ------------------------------ |
|   postal_code   | string     | null: false                    |
|   prefecture    | string     | null: false                    |
|       city      | string     | null: false                    |
|      address    | string     | null: false                    |
|  phone_number   | integer    | null: false                    |
|     order_id    | references | null: false, foreign_key: true |

### Association

- has_one :order