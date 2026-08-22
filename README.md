# Astra / TogetherCheaper — OkayCMS 4.5.2

Модуль «Разом дешевше» для комплектів із двох товарів.

## Архітектура

- vendor: `Astra`
- module: `TogetherCheaper`
- PHP namespace: `Okay\\Modules\\Astra\\TogetherCheaper`
- таблиця: `astra__together_cheaper`
- permission / AJAX entity alias: `astra__together_cheaper`
- Smarty tag: `Astra_together_cheaper`
- route: `Astra_together_cheaper_add`
- discount sign: `Astra_bundle`

Legacy-ідентифікатори `Sviat_*` у модулі не використовуються.

## Розміщення

Папка модуля повинна знаходитися тут:

`Okay/Modules/Astra/TogetherCheaper/`

## Що робить

- вибір двох товарів і конкретних варіантів;
- ручна ціна комплекту;
- блок комплекту на сторінках обох товарів;
- одне натискання додає обидва варіанти в кошик;
- серверна перевірка доступності та залишків;
- серверний розрахунок комплектної знижки;
- кількість комплектів = `min(qty A, qty B)`;
- не погіршує вже вигіднішу ціну іншої акції;
- сумісний із поточним Veles/Promo;
- GA4 `add_to_cart` для двох позицій.

## v1.1.0

Це перша чиста Astra-збірка. Якщо оновлюється тестова Astra v1.0.5, метод `update_1_1_0()` створює нову таблицю `astra__together_cheaper`. Дані зі старої тестової `sviat__together_cheaper` навмисно не імпортуються: фінальна архітектура не залежить від legacy-таблиці.
