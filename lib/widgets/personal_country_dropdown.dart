import 'package:country_provider/country_provider.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PersonalCountryDropdown extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final void Function(dynamic) onChanged;
  final String hintText;
  final dynamic selectedItem;

  PersonalCountryDropdown(
      {this.text,
        this.controller,
        this.onChanged,
        this.hintText,
        this.selectedItem});

  @override
  _PersonalCountryDropdownState createState() =>
      _PersonalCountryDropdownState();
}

class _PersonalCountryDropdownState extends State<PersonalCountryDropdown> {
  List<String> countries = ['United States of America'];

  getCountries() async {
    List<Country> countriesCountry = await CountryProvider.getAllCountries();

    for (Country country in countriesCountry) {
      countries.add(country.name);
    }
  }

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 10),
          DropdownSearch(
            hint: 'Country',
            popupBackgroundColor: AppColors.light,
            onChanged: widget.onChanged,
            dropDownButton:
            SvgPicture.asset('assets/images/icn_arrow_down.svg'),
            selectedItem: widget.selectedItem,
            dropdownSearchDecoration: InputDecoration(
              filled: true,
              fillColor: AppColors.light,
              contentPadding:
              EdgeInsets.only(left: 20, right: 0, top: 7.5, bottom: 7.5),
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.light,
                ),
                borderRadius: BorderRadius.circular(7.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.light,
                ),
                borderRadius: BorderRadius.circular(7.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.light,
                ),
                borderRadius: BorderRadius.circular(7.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.light,
                ),
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
            items: countries,
            mode: Mode.MENU,
          ),
        ],
      ),
    );
  }
}


