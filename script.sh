#!/bin/bash

find_image() {
  if [ -n "$(find . -name "$input_image.*" -print -quit 2>/dev/null)" ];
    then echo "Файл найден"
  else
    echo "Файл не найден"
    choice
  fi
}

check_format() {
  if [ "$output_format" = "png" ];
  then return 
  if [ "$output_format" = "jpg" ];
  then return
  if [ "$output_format" = "gif" ];
  then return
  else
    echo "Введён неверный формат, попробуйте ещё раз:"
    read output_format
    check_format "$output_format"
  fi
}

check_size() {
  if [[ $1 =~ ^[0-9]+x[0-9]+$ ]];
  then return
  else
    echo "неправильный формат изображения, повторите попытку:"
    read new_size
    check_size "$new_size"
  fi
}

change_image() {
  mogrify -format $output_format -resize $new_size $input_image
  echo "Файл успешно конвертирован"
}

choice() {
  echo "Желаете продолжить работу?"
  read answer
  if [ "$answer" = "1" ];
    then echo "Продолжаем"
    main_menu
  elif [ "$answer" = "0" ];
    then echo "Выход программы"
    exit 0
  else echo "Неккоректный выбор, попробуйте ещё раз"
    choice
  fi
}

main_menu() {
  echo "Введите имя файла:"
  read input_image
  find_image "$input_image"
  echo "Введите формат, в который нужно переконвертировать изображение (например jpg)"
  read output_format
  check_format "$output_format"
  echo "Введите размер нового изображения (в виде 123х123)"
  read new_size
  check_size "$new_size"
  change_image "$input_image" "$output_format" "$new_size"
  choice
}

main_menu
